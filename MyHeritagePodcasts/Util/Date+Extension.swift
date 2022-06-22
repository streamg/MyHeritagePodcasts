//
//  Date+Extension.swift
//  MyHeritagePodcasts
//
//  Created by Mihai-Ionut Ghete on 22.06.2022.
//

import Foundation

public extension Date {
    func prettyPrintDate(withFormat format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        let dateStringFormated = (formatter.string(from: self) as NSString) as String
        return dateStringFormated
    }
}
