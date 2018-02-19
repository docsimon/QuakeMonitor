//
//  QuakeMonitorTests.swift
//  QuakeMonitorTests
//
//  Created by doc on 18/02/2018.
//  Copyright © 2018 Simone Barbara. All rights reserved.
//

import XCTest
@testable import QuakeMonitor

class QuakeMonitorTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
//    func testBuildRequest(){
//        let vc = EarthquakeViewController()
//        var queryItems = [URLQueryItem]()
//        queryItems.append(URLQueryItem(name: "minmag", value: "6"))
//        queryItems.append(URLQueryItem(name: "limit", value: "20"))
//        let requestData = RequestData(scheme: "https", baseUrl: "earthquake.usgs.gov", path: "/fdsnws/event/1", query: queryItems)
//        let client = Client(controllerDelegate: vc, urlRequestData: requestData)
//
//
//    }
    
}
