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
    
    /// 특정 도시의 위치 정보를 가져옴
    func getCoordinate(city: String) -> Observable<Coordinate> {
        let coordinate = localDataSource.loadCoordinate(city: city)
        
        // 로컬에 저장된 위치 정보가 없으면 새로 요청함
        if coordinate.isEmpty || coordinate.count < 2 {
            let request = CoordinatesGetRequest(city: city, apiKey: remoteDataSource.apiKey)
            return remoteDataSource.getCoordinates(request)
                .compactMap { $0.first }
                .do { self.localDataSource.seveCoordinate(city: $0.name, lat: $0.lat, lon: $0.lon) }
                .map { response in
                    let coordinate = Coordinate(city: response.name, lat: response.lat, lon: response.lon)
                    return coordinate
                }
        }
        // 로컬에 저장된 위치 정보 사용
        else {
            return Observable.just(Coordinate(city: city, lat: coordinate[0], lon: coordinate[1]))
        }
    }
    
    /// 특정 도시의 날씨 정보를 가져옴
    func fetchWeathers(city: String, lat: Double, lon: Double) -> Observable<WeatherSection> {
        let request = WeathersGetRequest(lat: lat, lon: lon, appid: remoteDataSource.apiKey)
        return remoteDataSource.fetchWeathers(request)
            .map { $0.toModel(city: city, iconUrl: self.remoteDataSource.iconUrl) }
            .map { weatherSection in
                var weatherSection = weatherSection
                var newItems: [Weather] = []
                
                for weather in weatherSection.items {
                    if newItems.isEmpty { newItems.append(weather); continue }
                    guard let lastItem = newItems.last else { continue }
                    
                    let calendar = Calendar.current
                    let components = calendar.dateComponents([.hour], from: lastItem.day, to: weather.day)
                    let hoursGap = components.hour ?? 0
                    if hoursGap >= 24 { newItems.append(weather) }
                }

                weatherSection.items = newItems
                return weatherSection
            }
    }
}
