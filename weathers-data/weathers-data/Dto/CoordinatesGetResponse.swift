//
//  CoordinatesGetResponse.swift
//  weathers-data
//
//  Created by ios.kwon on 2023/06/02.
//

import Foundation

struct CoordinatesGetResponse: Codable {
    let name: String
    let lat: Double
    let lon: Double
}
