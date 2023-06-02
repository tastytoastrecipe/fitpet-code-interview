//
//  weather_appTests.swift
//  weather-appTests
//
//  Created by ios.kwon on 2023/06/01.
//

import XCTest
import RxDataSources

@testable import weather_app
@testable import weathers_domain

final class weather_appTests: XCTestCase {
    
    var datas: [WeatherSection] = []

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        datas.removeAll()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
        
        let testDatas = testCreateWeatherSections()
        
        XCTAssertFalse(testDatas.isEmpty)
    }

    func testCreateWeatherSections() -> [WeatherSection] {
//        let weather1 = Weather(day: <#T##String#>, wetherImgUrl: <#T##String#>, weatherText: <#T##String#>, minCelsius: <#T##String#>, maxCelsius: <#T##String#>)
//        let section1 = WeatherSection(header: <#T##String#>, items: <#T##[Weather]#>)
        
        let imgUrl = "https://play-lh.googleusercontent.com/8llahPLsLypSscPaqO__KtfWq27aWUR89mQ18qgGFRe4WEDNGK8CiD7zavXUxfqh6Yc"
        let weather1 = Weather(day: "Today", wetherImgUrl: imgUrl, weatherText: "Clear", minCelsius: "11°C", maxCelsius: "23°C")
        let weather2 = Weather(day: "Tomorrow", wetherImgUrl: imgUrl, weatherText: "Heavy Cloud", minCelsius: "6°C", maxCelsius: "17°C")
        let weather3 = Weather(day: "Sat 30 Nov", wetherImgUrl: imgUrl, weatherText: "Light Cloud", minCelsius: "7°C", maxCelsius: "18°C")
        let weather4 = Weather(day: "Sun 1 Dec", wetherImgUrl: imgUrl, weatherText: "Light Cloud", minCelsius: "6°C", maxCelsius: "18°C")
        let weather5 = Weather(day: "Mon 2 Dec", wetherImgUrl: imgUrl, weatherText: "Light Rain", minCelsius: "3°C", maxCelsius: "14°C")
        let section1 = WeatherSection(header: "Seoul", items: [weather1, weather2, weather3, weather4, weather5])
        
        XCTAssertNotNil(URL(string: imgUrl))
        
        return [section1]
    }

}