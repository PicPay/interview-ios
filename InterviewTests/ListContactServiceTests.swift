//
//  InterviewTests.swift
//  InterviewTests
//
//  Created by Fernando Sousa on 05/02/20.
//  Copyright © 2020 PicPay. All rights reserved.
//

import XCTest
@testable import Interview

class ListContactServiceTests: XCTestCase {
    
    var mockData: Data? {
        """
        {
          "id": 2,
          "name": "Beyonce",
          "photoURL": "https://api.adorable.io/avatars/285/a2.png"
        }
        """.data(using: .utf8)
    }

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
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

}
