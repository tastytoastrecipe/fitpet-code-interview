//
//  CoordinatesGetRequest.swift
//  weathers-data
//
//  Created by ios.kwon on 2023/06/02.
//

import Foundation

struct CoordinatesGetRequest: Codable {
    let city: String
    let apiKey: String
    
    enum CodingKeys: String, CodingKey {
        case city = "q"
        case apiKey = "appid"
    }
}
