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
            
            return Observable<Mutation>.create { emitter in
                let coordinateUseCase = self.container.resolve(GetCoordinatesUseCase.self)!
                
                // 위도, 경도 가져오기
                let city = City.seoul.rawValue
                coordinateUseCase.run(city: city)
                    .subscribe(onNext: { coordinate in
                        print(" 🐻‍❄️ [COORDINATE]\n\(coordinate)")
                
                        // 해당 위치의 날씨 가져오기
                        let weathersUseCase = self.container.resolve(FetchWeathersUseCase.self)!
                        weathersUseCase.run(city: coordinate.city, lat: coordinate.lat, lon: coordinate.lon)
                            .subscribe(onNext: { weatherSection in
                                print(" ☀️☁️ [WEATHER SECTION]\n\(weatherSection)")
                                emitter.onNext(.fetch([weatherSection]))
                                emitter.onCompleted()
                            }, onError: { err in
                                emitter.onError(err)
                            })
                            .disposed(by: self.disposeBag)
                        
                        
                    })
                    .disposed(by: self.disposeBag)
                
                
                
                return Disposables.create()
            }
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
    
    
}
