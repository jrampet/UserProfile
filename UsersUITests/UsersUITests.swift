//
//  UsersUITests.swift
//  UsersUITests
//
//  Created by Jeyaram on 05/07/21.
//

import XCTest

class UsersUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
  
    

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
                    }
       
      
                        
                                
    }
    
    func testGowithFlow(){
        let app = XCUIApplication()
        app.launch()
        sleep(5)
        let searchSearchField = app.searchFields["Search"]
        XCTAssert(searchSearchField.exists)
        searchSearchField.tap()
        sleep(5)
        let gKey = app/*@START_MENU_TOKEN@*/.keys["G"]/*[[".keyboards.keys[\"G\"]",".keys[\"G\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        gKey.tap()
        let kKey = app/*@START_MENU_TOKEN@*/.keys["k"]/*[[".keyboards.keys[\"k\"]",".keys[\"k\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        kKey.tap()
        let deleteKey = app/*@START_MENU_TOKEN@*/.keys["delete"]/*[[".keyboards.keys[\"delete\"]",".keys[\"delete\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        deleteKey.tap()
        searchSearchField.buttons["Clear text"].tap()
        app/*@START_MENU_TOKEN@*/.staticTexts["Cancel"]/*[[".buttons[\"Cancel\"].staticTexts[\"Cancel\"]",".staticTexts[\"Cancel\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()

        let scrollViewsQuery = XCUIApplication().scrollViews
        let tablesQuery = scrollViewsQuery.otherElements.tables
        tablesQuery/*@START_MENU_TOKEN@*/.cells.containing(.staticText, identifier:"sara.andersen@example.com").element/*[[".cells.containing(.staticText, identifier:\"Sara Andersen\").element",".cells.containing(.staticText, identifier:\"sara.andersen@example.com\").element"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.swipeLeft()
        sleep(5)
        let element = scrollViewsQuery.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element(boundBy: 0)
        element.swipeLeft()
        sleep(5)
        
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Filters"]/*[[".otherElements[\"Filters\"].staticTexts[\"Filters\"]",".staticTexts[\"Filters\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.swipeRight()
        element.swipeRight()
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Adina Barbosa"]/*[[".cells.staticTexts[\"Adina Barbosa\"]",".staticTexts[\"Adina Barbosa\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.swipeUp()

       
    }
}
