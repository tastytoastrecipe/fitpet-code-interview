//
//  WeathersGetResponse.swift
//  weathers-data
//
//  Created by ios.kwon on 2023/06/02.
//

import Foundation
import weathers_domain


struct WeathersGetResponse: Codable {
    let list: [WeatherInfoResponse]
}

struct WeatherInfoResponse: Codable {
    let main: MainResponse
    let weather: [WeatherResponse]
    let dt_txt: String
}

struct MainResponse: Codable {
    let temp_min: Double
    let temp_max: Double
}

struct WeatherResponse: Codable {
    let description: String
    let icon: String
}

extension WeathersGetResponse {
    
    // WeatherSection 타입으로 변경
    func toModel(city: String, iconUrl: String) -> WeatherSection {
        var weathers: [Weather] = []
        
        for e in self.list {
            guard let weatherData = e.weather.first else { continue }
            let iconUrl = String(format: iconUrl, weatherData.icon)
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            guard let date = dateFormatter.date(from: e.dt_txt) else { continue }
            
            let weather = Weather(day: date,
                                  weatherImgUrl: iconUrl,
                                  weatherText: weatherData.description,
                                  minCelsius: e.main.temp_min,
                                  maxCelsius: e.main.temp_max)
            
            weathers.append(weather)
        }
        
        let weatherSection = WeatherSection(header: city, items: weathers)
        return weatherSection
    }
}

