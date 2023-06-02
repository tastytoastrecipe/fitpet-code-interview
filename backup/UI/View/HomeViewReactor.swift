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
        case fetch(Result<[WeatherSection], Error>)
    }
    
    struct State {
        var datas: [WeatherSection] = []
    }
    
    var initialState: State
    var container: Container
    
    init(container: Container) {
        self.container = container
        initialState = State()
        action.onNext(.fetch)
        
        
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .fetch:
            // fetch datas..
            //
            let testResult = Result<[WeatherSection], Error>.success([])
            return Observable.just(.fetch(testResult))
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var state = state
        switch mutation {
        case .fetch(let result):
            
            do {
                let datas = try result.get()
                state.datas = datas
            } catch {
                print(" 🙈 [HomeViewModel - fetch] failed.. \n\(error.localizedDescription)")
            }
            
            break
        }
        
        return state
    }
    
    
}
