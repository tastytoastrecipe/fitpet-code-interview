//
//  DataContainer.swift
//  weathers-data
//
//  Created by ios.kwon on 2023/06/01.
//

import Foundation
import Swinject

public class DataContainer {
    public let container = Container()
    
    public init() {
        container.register(RemoteDataSource.self) { _ in RemoteDataSource() }.inObjectScope(.container)
        container.register(LocalDataSource.self) { _ in LocalDataSource() }.inObjectScope(.container)
    }
}
