//
//  GetCoordinatesUseCase.swift
//  weathers-domain
//
//  Created by ios.kwon on 2023/06/02.
//

import Foundation
import RxSwift

public class GetCoordinatesUseCase: UseCase {
    public func run(city: String) -> Observable<Coordinate> {
        return repository.getCoordinate(city: city)
    }
}
