//
//  ExString.swift
//  weathers-data
//
//  Created by ios.kwon on 2023/06/02.
//

import Foundation

extension String {
    func toDate() -> Date? {
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = [.withInternetDateTime]
        return formatter.date(from: self)
    }
}
