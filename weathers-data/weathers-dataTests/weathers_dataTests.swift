//
//  weathers_dataTests.swift
//  weathers-dataTests
//
//  Created by ios.kwon on 2023/06/07.
//

import XCTest

@testable import weathers_data


/**
 
 # LocalDataTests #
 
 로컬에 저장되는 데이터(위치정보)를 임의로 생성하고 테스트함
 
*/

final class LocalDataTests: XCTestCase {
    
    let city: String = "Seoul"

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        
        // 서울 위치 정보 저장
        UserDefaults.standard.set([37.5642135, 127.0016985], forKey: city)
        
        // 저장된 위치 정보 가져옴
        let coordinate = (UserDefaults.standard.value(forKey: city) as? [Double]) ?? []
        
        XCTAssertFalse(coordinate.isEmpty)
        
        print("💬 Seoul: \(coordinate)")
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }

}
