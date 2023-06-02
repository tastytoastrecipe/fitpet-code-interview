//
//  WeathersGetRequest.swift
//  weathers-data
//
//  Created by ios.kwon on 2023/06/02.
//

import Foundation

struct WeathersGetRequest: Codable {
    let lat: Double
    
    let lon: Double
    
    let appid: String
}
