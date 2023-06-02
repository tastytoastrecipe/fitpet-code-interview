//
//  WeatherRepositoryImpl.swift
//  weathers-data
//
//  Created by ios.kwon on 2023/06/01.
//

import Foundation
import RxSwift
import weathers_domain

class WeatherRepositoryImpl: WeatherRepository {
    
    private let remoteDataSource: RemoteDataSource
    private let localDataSource: LocalDataSource
    
    init(remoteDataSource: RemoteDataSource, localDataSource: LocalDataSource) {
        self.remoteDataSource = remoteDataSource
        self.localDataSource = localDataSource
    }
    
    func getCoordinates(city: String) -> Observable<Coordinate> {
        let request = CoordinatesGetRequest(city: city, apiKey: remoteDataSource.apiKey)
        return remoteDataSource.getCoordinates(request)
            .compactMap { $0.first }
            .map { response in
                let coordinate = Coordinate(city: response.name, lat: response.lat, lon: response.lon)
                return coordinate
            }
    }
    
    func fetchWeathers(city: String, lat: Double, lon: Double) -> Observable<WeatherSection> {
        let request = WeathersGetRequest(lat: lat, lon: lon, appid: remoteDataSource.apiKey)
        return remoteDataSource.fetchWeathers(request)
            .map { response in
                
                var weathers: [Weather] = []
                for e in response.list {
                    guard let weatherData = e.weather.first else { continue }
                    let iconUrl = String(format: self.remoteDataSource.iconUrl, weatherData.icon)
                    
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
                    guard let date = dateFormatter.date(from: e.dt_txt) else { continue }
                    
                    let weather = Weather(day: date,
                                          wetherImgUrl: iconUrl,
                                          weatherText: weatherData.main,
                                          minCelsius: e.main.temp_min,
                                          maxCelsius: e.main.temp_max)
                    
                    weathers.append(weather)
                }
                
                let weatherSection = WeatherSection(header: city, items: weathers)
                return weatherSection
            }
    }
}
