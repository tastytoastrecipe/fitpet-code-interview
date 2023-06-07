//
//  HomeViewReactor.swift
//  weather-app
//
//  Created by ios.kwon on 2023/06/01.
//

import Foundation
import ReactorKit
import Swinject
import weathers_domain
import logger


/**
 
 # HomeViewReactor #
 
 홈 화면의 Reactor (ViewModel)
 
*/

class HomeViewReactor: Reactor {
    
    enum Action {
        case fetch
    }
    
    enum Mutation {
        case fetch([WeatherSection])
    }
    
    struct State {
        var datas: [WeatherSection] = []
    }
    
    var initialState: State
   
    var container: Container
    
    let disposeBag = DisposeBag()
    
    init(container: Container) {
        self.container = container
        initialState = State()
        action.onNext(.fetch)
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .fetch:
            return getWeathersOfAllCity()
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var state = state
        switch mutation {
        case .fetch(let weatherSections):
            state.datas = weatherSections
        }
        
        return state
    }
    
    /// 날씨 가져오기
    private func getWeathersOfAllCity() -> Observable<Mutation> {
        return Observable<Mutation>.create { emitter in
            
            
            let cities = City.allCases.map { $0.rawValue }
            let weathersUseCase = self.container.resolve(FetchWeathersUseCase.self)!
            weathersUseCase.run(cities: cities)
                .subscribe(onNext: { weatherSections in
                    emitter.onNext(.fetch(weatherSections))
                    emitter.onCompleted()
                }, onError: { err in
                    emitter.onError(err)
                })
                .disposed(by: self.disposeBag)
            
            return Disposables.create()
        }
    }
    
    
}
