//
//  UseCase.swift
//  weathers-domain
//
//  Created by ios.kwon on 2023/06/02.
//

import Foundation

public class UseCase {
    let repository: WeatherRepository
    
    public init(repository: WeatherRepository) {
        self.repository = repository
    }
}
