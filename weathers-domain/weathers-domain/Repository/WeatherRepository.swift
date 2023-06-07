//
//  WeatherRepository.swift
//  weathers-domain
//
//  Created by ios.kwon on 2023/06/01.
//

import Foundation
import RxSwift

public protocol WeatherRepository {
    
    /// 특정 도시의 위치 정보를 가져옴
    func getCoordinate(city: String) -> Observable<Coordinate>
    
    /// 특정 도시의 날씨 정보를 가져옴
    func fetchWeathers(city: String, lat: Double, lon: Double) -> Observable<WeatherSection>
}
