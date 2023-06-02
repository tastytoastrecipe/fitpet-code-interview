//
//  DataContainer.swift
//  weathers-data
//
//  Created by ios.kwon on 2023/06/01.
//

import Foundation
import Swinject
import weathers_domain

public class DataContainer {
    public let container = Container()
    
    public init() {
        container.register(RemoteDataSource.self) { _ in RemoteDataSource() }.inObjectScope(.container)
        container.register(LocalDataSource.self) { _ in LocalDataSource() }.inObjectScope(.container)
        
        container.register(WeatherRepository.self) { r in
            WeatherRepositoryImpl(remoteDataSource: r.resolve(RemoteDataSource.self)!,
                                  localDataSource: r.resolve(LocalDataSource.self)!)
        }.inObjectScope(.container)
    }
}
