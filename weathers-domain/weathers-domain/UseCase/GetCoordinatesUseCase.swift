//
//  GetCoordinatesUseCase.swift
//  weathers-domain
//
//  Created by ios.kwon on 2023/06/02.
//

import Foundation
import RxSwift


/**
 
 # GetCoordinatesUseCase #
 
 특정 도시의 위치 정보를 요청하는 UseCase
 
*/

public class GetCoordinatesUseCase: UseCase {
    public func run(city: String) -> Observable<Coordinate> {
        return repository.getCoordinate(city: city)
    }
}
