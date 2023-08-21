//
//  DNYK_iOSUITests.swift
//  DNYK-iOSUITests
//
//  Created by John Patrick Teruel on 8/10/23.
//

import XCTest

final class DNYK_iOSUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        let app = XCUIApplication()
        app.launchArguments = ["--in-memory"]
        app.launch()
        app.buttons["Add"].tap()
        app.buttons["Choose Category"].tap()
        app.collectionViews.buttons["Ready to Assign"].tap()
        XCTAssert(app.staticTexts["Ready to Assign"].exists)
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
