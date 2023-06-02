//
//  Coordinate.swift
//  weathers-domain
//
//  Created by ios.kwon on 2023/06/02.
//

import Foundation

public struct Coordinate {
    public let city: String
    
    public let lat: Double
    
    public let lon: Double
    
    public init(city: String, lat: Double, lon: Double) {
        self.city = city
        self.lat = lat
        self.lon = lon
    }
}
