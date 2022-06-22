//
//  PodcastsTableViewModel.swift
//  MyHeritagePodcasts
//
//  Created by Mihai-Ionut Ghete on 22.06.2022.
//

import Foundation
import Combine

class PodcastsTableViewModel {
    private let searchLimit = 50
    private(set) var reloadData: Observable<Bool> = Observable(false)
    
    private var podcasts = [Podcast]()
    private var debounceSearchTimer: Timer?
    
    var viewModels = [PodcastViewModel]()
    
    func newSearchString(searchString: String?) {
        // delay searching; we don't want to search while user is typing
        self.debounce(timer: &self.debounceSearchTimer, seconds:0.5) { [weak self] in
            self?.fetchPodcasts(searchString: searchString)
        }
    }
    
    func fetchPodcasts(searchString: String?) {
        var cleanedString = searchString ?? ""
        cleanedString = cleanedString
            .lowercased()
            .trimmingCharacters(in: CharacterSet.init(charactersIn: " "))
        DataManager.shared.fetchPodcasts(from: cleanedString, limit: searchLimit) { [weak self] podcasts in
            if let podcasts = podcasts {
                self?.podcasts = podcasts
            } else {
                self?.podcasts.removeAll()
            }
            self?.configureViewModels()
        }
    }
    
    private func debounce(timer: inout Timer? ,seconds: TimeInterval, function: @escaping () -> Swift.Void ) {
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: seconds, repeats: false, block: { _ in
            function()
        })
    }
    
    // create all viewModels here and just set the appropriate one to calls as they are being reused/created
    private func configureViewModels() {
        viewModels.removeAll()
        for podcast in podcasts {
            let viewModel = PodcastViewModel()
            viewModel.podcast = podcast
            viewModels.append(viewModel)
        }
        self.reloadData.value = true
    }
    
    func itemsCount() -> Int {
        return podcasts.count
    }
}
