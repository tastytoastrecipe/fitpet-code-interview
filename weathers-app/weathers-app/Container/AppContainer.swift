//
//  AppContainer.swift
//  weather-app
//
//  Created by ios.kwon on 2023/06/01.
//

import Foundation
import weathers_data
import weathers_domain

public class AppContainer {
    public let container = DataContainer().container
    
    init() {
        container.register(GetCoordinatesUseCase.self) { r in
            GetCoordinatesUseCase(repository: r.resolve(WeatherRepository.self)!)
        }
        .inObjectScope(.container)
    }
    
}
