//
//  Podcast.swift
//  MyHeritagePodcasts
//
//  Created by Mihai-Ionut Ghete on 22.06.2022.
//

import Foundation

public struct Podcast: Codable {
    enum CodingKeys: String, CodingKey {
        case artistName = "artistName"
        case trackName = "trackName"
        case artwork100URLString = "artworkUrl100"
        case artwork600URLString = "artworkUrl600"
        case releaseDateString = "releaseDate"
    }
    public var artistName: String?
    public var trackName: String?
    var artwork100URLString: String?
    var artwork600URLString: String?
    var releaseDateString: String?
    
    public var realeaseDate: Date? {
        get {
            if let releaseDateString = releaseDateString {
                return releaseDateString.toDate(withFormat: "yyyy-MM-dd'T'HH:mm:ssZ")
            }
            return nil
        }
    }
}
