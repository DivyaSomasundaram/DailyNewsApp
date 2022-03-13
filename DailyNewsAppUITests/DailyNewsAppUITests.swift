//
//  DailyNewsAppUITests.swift
//  DailyNewsAppUITests
//
//  Created by MobiloApps on 13/03/22.
//

import XCTest

class DailyNewsAppUITests: XCTestCase {
    let app = XCUIApplication()
    
    override func setUpWithError() throws {
        // UI tests must launch the application that they test.
        app.launch()
    }
    
    func testNewsListSelection() throws {
        //Code to tap the news list
        let tablesQuery = app.tables
        let firstCell = tablesQuery.element(boundBy: 0).cells.element(boundBy: 0)
        firstCell.tap()
        XCTAssert(app.staticTexts["Updated on:"].exists)
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
