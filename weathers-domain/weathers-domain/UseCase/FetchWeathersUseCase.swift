//
//  FetchWeathersUseCase.swift
//  weathers-domain
//
//  Created by ios.kwon on 2023/06/02.
//

import Foundation
import RxSwift


/**
 
 # FetchWeathersUseCase #
 
 도시의 날씨 정보를 요청하는 UseCase
 
*/

public class FetchWeathersUseCase: UseCase {
    
    // 특정 도시의 날씨 정보 가져옴
    public func run(city: String) -> Observable<WeatherSection> {
        return repository.getCoordinate(city: city)
            .flatMapLatest { self.repository.fetchWeathers(city: $0.city, lat: $0.lat, lon: $0.lon) }
    }
    
    // 여러 도시의 날씨 정보 가져옴
    public func run(cities: [String]) -> Observable<[WeatherSection]> {
        var observables: [Observable<WeatherSection>] = []
        
        cities.forEach { observables.append(run(city: $0)) }
        
        return Observable.zip(observables)
    }
}
