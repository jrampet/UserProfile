//
//  UsersTests.swift
//  UsersTests
//
//  Created by Jeyaram on 07/07/21.
//

import XCTest
@testable import Users
class UsersTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        let profileUrl = api.url
        let expectation = expectation(description: "SomeService does stuff and runs the callback closure")
        FetchApi.request(url: profileUrl, completion:  {
            (data) in
            XCTAssertNotNil(data)
            expectation.fulfill()
        })
        waitForExpectations(timeout: 5) { error in
          if let error = error {
            XCTFail("waitForExpectationsWithTimeout errored: \(error)")
          }
        }
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

   
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }

}
