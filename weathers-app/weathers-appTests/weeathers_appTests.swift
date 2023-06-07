//
//  weeathers_appTests.swift
//  weathers-appTests
//
//  Created by ios.kwon on 2023/06/05.
//

import XCTest
import RxDataSources

@testable import weathers_app
@testable import weathers_domain


/**
 
 # WeathersTests #
 
 앱에서 사용하는 데이터(Model)들을 임의로 생성하고 테스트함
 
*/

final class WeathersTests: XCTestCase {
    
    let kelvin: Double = 273.15

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        let mocks = createMocks()
        
        testFiltering(mocks: mocks)
        
        testUrls(mocks: mocks)
    }
    
    /// 날씨 정보 테스트
    func testFiltering(mocks: [Weather]) {
        var newItems: [Weather] = []
        
        // 날짜(일) 별로 한개씩만 남겨지게 필터링
        for weather in mocks {
            if newItems.isEmpty { newItems.append(weather); continue }
            guard let lastItem = newItems.last else { continue }
            
            let calendar = Calendar.current
            let components = calendar.dateComponents([.hour], from: lastItem.day, to: weather.day)
            let hoursGap = components.hour ?? 0
            if hoursGap >= 24 { newItems.append(weather) }
        }
        
        // 요청하는 API에서 5일치의 날짜를 받기 때문에 총 5개가 남아있는지 확인
        XCTAssertTrue(newItems.count == 5, "wrong item count")
        
        // 아이템들의 날짜가 모두 다른지 확인
        let uniqueDatas = Set(newItems.map { $0.day })
        XCTAssertEqual(uniqueDatas.count, newItems.count, "items are not unique")
        
        // 온도의 유효성 확인
        newItems.forEach { weather in
            XCTAssertTrue(weather.minCelsius < kelvin)
            XCTAssertTrue(weather.maxCelsius < kelvin)
        }
    }
    
    /// 날씨 아이콘 url 테스트
    func testUrls(mocks: [Weather]) {
        mocks.forEach { weather in
            XCTAssertNotNil(URL(string: weather.weatherImgUrl), "unavailable icon url\n => \(weather.weatherImgUrl)")
        }
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    /// 6월 5일 9시부터 3시간 간격으로 임의의 날씨 데이터 생성
    func createMocks() -> [Weather] {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let baseDate = dateFormatter.date(from: "2023-06-05 09:00:00")!

        var weatherList: [Weather] = []

        for i in 0 ..< 40 {
            let day = Calendar.current.date(byAdding: .hour, value: 3 * i, to: baseDate)!
            let weatherImgUrl = "https://openweathermap.org/img/w/02d.png"
            let weatherText = "Weather \(i + 1)"
            let minCelsius = Double.random(in: 280.0 ..< 320.0) - kelvin
            let maxCelsius = Double.random(in: minCelsius ..< 320.0) - kelvin
            
            let weather = Weather(day: day,
                                  weatherImgUrl: weatherImgUrl,
                                  weatherText: weatherText,
                                  minCelsius: minCelsius,
                                  maxCelsius: maxCelsius)
            weatherList.append(weather)
        }
        
        return weatherList
    }

}
