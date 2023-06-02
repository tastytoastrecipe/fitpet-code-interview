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
}
