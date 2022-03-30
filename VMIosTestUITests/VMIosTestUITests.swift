//
//  VMIosTestUITests.swift
//  VMIosTestUITests
//
//  Created by Sanjay Raskar on 29/03/22.
//

import XCTest

class VMIosTestUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testAppFlow() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()
        
        let tabBar = app.tabBars["Tab Bar"]
        XCTAssertTrue(tabBar.exists)
        tabBar.buttons["Contacts"].tap()
        XCTAssertTrue(tabBar.buttons["Contacts"].exists)

        let tablesQuery = app.tables
        let element = tablesQuery.children(matching: .cell).element(boundBy: 1)
        _ = element.waitForExistence(timeout: 2)
        XCTAssertTrue(element.exists)
        element.tap()
        XCTAssertTrue(app.images["image"].exists)
        XCTAssertTrue(app.staticTexts["Favourite color"].exists)
        XCTAssertTrue (app.staticTexts["job title"].exists)
        tabBar.buttons["Rooms"].tap()
        
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
