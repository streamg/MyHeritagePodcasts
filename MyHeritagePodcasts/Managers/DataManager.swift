//
//  DataManager.swift
//  MyHeritagePodcasts
//
//  Created by Mihai-Ionut Ghete on 22.06.2022.
//

import Foundation

private let searchURLString = "https://itunes.apple.com/search?term=<search_term>&entity=podcast&limit=<limit>"

class DataManager {
    static let shared = DataManager()
    let searchQueue = dispatch_queue_serial_t(label: "myHeritage.poc.search.queue")
    
    public func fetchPodcasts(from searchString: String = "", limit: Int, completion: @escaping ([Podcast]?) -> Void) {
        searchQueue.async {
            let urlString = searchURLString
                .replacingOccurrences(of: "<search_term>",
                                      with: searchString)
                .replacingOccurrences(of: "<limit>",
                                      with: "\(limit)")
            
            if let url = URL(string: urlString) {
                if let data = try? Data(contentsOf: url) {
                    let decoder = JSONDecoder()
                    if let jsonPodcasts = try? decoder.decode(Podcasts.self, from: data) {
                        DispatchQueue.main.async {
                            completion(jsonPodcasts.results)
                        }
                    } else {
                        DispatchQueue.main.async {
                            completion(nil)
                        }
                    }
                } else {
                    DispatchQueue.main.async {
                        completion(nil)
                    }
                }
            }
        }
    }
}


