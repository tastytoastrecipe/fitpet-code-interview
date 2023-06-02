//
//  WeathersGetResponse.swift
//  weathers-data
//
//  Created by ios.kwon on 2023/06/02.
//

import Foundation


struct WeathersGetResponse: Codable {
    let list: [WeatherInfoResponse]
}

struct WeatherInfoResponse: Codable {
    let main: MainResponse
    let weather: [WeatherResponse]
//    let dt_txt: Date
    let dt_txt: String
}

struct MainResponse: Codable {
    let temp_min: Double
    let temp_max: Double
}

struct WeatherResponse: Codable {
    let main: String
    let icon: String
}

