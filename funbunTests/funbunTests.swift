//
//  funbunTests.swift
//  funbunTests
//
//  Created by william Vise on 12/7/2022.
//

import XCTest
@testable import funbun

class funbunTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testFetch() async throws {
        let itemcount = await DataHandler.GetDBItems().capacity
        XCTAssert(itemcount > 0)
        
    }
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
