//
//  Util.swift
//  MyHeritagePodcasts
//
//  Created by Mihai-Ionut Ghete on 22.06.2022.
//

import Foundation

public extension String {
    func toDate(withFormat format: String) -> Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.date(from: self)
    }
}

