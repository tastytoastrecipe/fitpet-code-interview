//
//  ExDate.swift
//  weathers-data
//
//  Created by ios.kwon on 2023/06/02.
//

import Foundation

extension Date {
    func toWeatherDateString() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "E d MMM"
        return formatter.string(from: self)
    }
}
