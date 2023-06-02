//
//  RemoteDataSource.swift
//  weathers-data
//
//  Created by ios.kwon on 2023/06/01.
//

import Foundation
import RxSwift
import Alamofire

class RemoteDataSource {
    
    var apiKey: String { "01ce61da34e19904621517d1b3590d27" }
    var iconUrl: String { "https://openweathermap.org/img/wn/%@.png" }
    
    private var apiHost: String = "http://api.openweathermap.org/"
    private var coodinatesPath: String = "geo/1.0/direct"
    private var weathersPath: String = "data/2.5/forecast"
    
    private var jsonEncoder: JSONParameterEncoder
    private var jsonDecoder: JSONDecoder
    
    init() {
        jsonEncoder = JSONParameterEncoder()
        jsonDecoder = JSONDecoder()
    }
    
    func getCoordinates(_ param: CoordinatesGetRequest) -> Observable<[CoordinatesGetResponse]> {
        return Observable.create { emitter in
            let tag = "\(type(of: self))/\(#function)"
            let url = "\(self.apiHost)\(self.coodinatesPath)"
            
            AF.request(url, method: .get, parameters: param)
                .response(completionHandler: { self.printLog(tag: tag, $0.data) })
                .responseDecodable(of: [CoordinatesGetResponse].self, decoder: self.jsonDecoder) {
                    switch $0.result {
                    case .success(let value):
                        emitter.onNext(value)
                        emitter.onCompleted()
                    case .failure(let error):
                        emitter.onError(error)
                    }
                }
            return Disposables.create()
        }
    }
    
    func fetchWeathers(_ param: WeathersGetRequest) -> Observable<WeathersGetResponse> {
        return Observable.create { emitter in
            let tag = "\(type(of: self))/\(#function)"
            let url = "\(self.apiHost)\(self.weathersPath)"
            
            AF.request(url, method: .get, parameters: param)
                .response(completionHandler: { self.printLog(tag: tag, $0.data) })
                .responseDecodable(of: WeathersGetResponse.self, decoder: self.jsonDecoder) {
                    switch $0.result {
                    case .success(let value):
                        emitter.onNext(value)
                        emitter.onCompleted()
                    case .failure(let error):
                        emitter.onError(error)
                    }
                }
            
            return Disposables.create()
        }
    }
    
    
    /// 로그 출력
    private func printLog(tag: String, _ data: Data?) {
        if let data = data,
           let json = String(data: data, encoding: .utf8)
        {
            print("[\(nowString()), \(tag)]\n📥 Response : \(json)")
        } else {
            print("[\(nowString()), \(tag)]\n📥 Response : N/A")
        }
    }
    
    private func nowString() -> String {
        let df = DateFormatter()
        df.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        df.timeZone = NSTimeZone.local
        return df.string(from: Date())
    }
}
