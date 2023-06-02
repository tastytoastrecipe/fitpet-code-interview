//
//  Weather.swift
//  weathers-domain
//
//  Created by ios.kwon on 2023/06/01.
//

import Foundation
import RxDataSources

public struct Weather {
    public let day: String
    public let wetherImgUrl: String
    public let weatherText: String
    public let minCelsius: String
    public let maxCelsius: String
    
    public init(day: String, wetherImgUrl: String, weatherText: String, minCelsius: String, maxCelsius: String) {
        self.day = day
        self.wetherImgUrl = wetherImgUrl
        self.weatherText = weatherText
        self.minCelsius = minCelsius
        self.maxCelsius = maxCelsius
    }
}

public struct WeatherSection {
    public var header: String
    public var items: [Weather]
    
    public init(header: String, items: [Weather]) {
        self.header = header
        self.items = items
    }
}

extension WeatherSection: SectionModelType {
    public typealias Item = Weather
    
    public init(original: WeatherSection, items: [Weather]) {
        self = original
        self.items = items
    }
    
}
