//
//  DecARUITests.swift
//  DecARUITests
//
//  Created by iosdev on 16.11.2022.
//

import XCTest

final class DecARUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testSettings() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()
        
        let settings = app.navigationBars["_TtGC7SwiftUI19UIHosting"].buttons["Settings"]
            
        XCTAssertTrue(settings.exists)
        settings.tap()
        
        let swipedMenu = app.windows.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element
        
        XCTAssertTrue(swipedMenu.exists)
        
        swipedMenu.swipeLeft()
                                         
    }
    
    func testListings() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()
        
        let addButton = XCUIApplication().navigationBars["_TtGC7SwiftUI19UIHosting"].buttons["Add"]
        
        XCTAssertTrue(addButton.exists)
        addButton.tap()
        
        let cancel = XCUIApplication().alerts["Add listing"].scrollViews.otherElements.buttons["Cancel"]
        XCTAssertTrue(cancel.exists)
        cancel.tap()
        
        addButton.tap()
        let addAlert = XCUIApplication().alerts["Add listing"].scrollViews.otherElements.buttons["Add"]
        XCTAssertTrue(addAlert.exists)
        addAlert.tap()
        
        let editBtn = app.navigationBars["_TtGC7SwiftUI19UIHosting"].buttons["Edit"]
        XCTAssertTrue(editBtn.exists)
        editBtn.tap()
        
        let tablesQuery = app.tables
        XCTAssertTrue(tablesQuery.element.exists)
        
        let delBtn1 = tablesQuery.children(matching: .cell).element(boundBy: 0).buttons["Delete "]
        XCTAssertTrue(delBtn1.exists)
        delBtn1.tap()
        
        let delBtn2 = tablesQuery/*@START_MENU_TOKEN@*/.buttons["Delete"]/*[[".cells.buttons[\"Delete\"]",".buttons[\"Delete\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        XCTAssertTrue(delBtn2.exists)
        delBtn2.tap()
        
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
