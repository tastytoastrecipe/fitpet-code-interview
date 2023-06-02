//
//  FetchWeathersUseCase.swift
//  weathers-domain
//
//  Created by ios.kwon on 2023/06/02.
//

import Foundation
import RxSwift

public class FetchWeathersUseCase: UseCase {
    public func run(city: String, lat: Double, lon: Double) -> Observable<WeatherSection> {
        return repository.fetchWeathers(city: city, lat: lat, lon: lon)
    }
}
