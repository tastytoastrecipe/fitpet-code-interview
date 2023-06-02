//
//  WeatherRepository.swift
//  weathers-domain
//
//  Created by ios.kwon on 2023/06/01.
//

import Foundation
import RxSwift

public protocol WeatherRepository {
    func getCoordinates(city: String) -> Observable<Coordinate>
    func fetchWeathers(city: String, lat: Double, lon: Double) -> Observable<WeatherSection>
}
