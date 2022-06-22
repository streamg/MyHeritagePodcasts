//
//  PodcastCellViewModel.swift
//  MyHeritagePodcasts
//
//  Created by Mihai-Ionut Ghete on 22.06.2022.
//

import Foundation

class PodcastViewModel {
    private(set) var artistName: Observable<String> = Observable("-")
    private(set) var trackName: Observable<String> = Observable("-")
    private(set) var thumbURL: Observable<URL?> = Observable(nil)
    private(set) var thumbURL600: Observable<URL?> = Observable(nil)
    private(set) var releaseDate: Observable<String> = Observable("-")
    
    var podcast: Podcast! {
        didSet {
            artistName.value = podcast.artistName ?? "-"
            trackName.value = podcast.trackName ?? "-"
            if let urlString = podcast.artwork100URLString, let url = URL(string: urlString) {
                thumbURL.value = url
            } else {
                thumbURL.value = nil
            }
            
            if let urlString = podcast.artwork600URLString, let url = URL(string: urlString) {
                thumbURL600.value = url
            } else {
                thumbURL600.value = nil
            }
            
            if let releaseDateString = podcast.realeaseDate?.prettyPrintDate(withFormat: "MMM d yyyy, h:mm a") {
                releaseDate.value = "Release date: "+releaseDateString
            }
        }
    }
}
