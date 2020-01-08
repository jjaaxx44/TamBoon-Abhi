//
//  TamBoonExampleUITests.swift
//  TamBoonExampleUITests
//
//  Created by Abhishek Chaudhari on 07/01/20.
//  Copyright © 2020 Abhishek Chaudhari. All rights reserved.
//

import XCTest

class TamBoonExampleUITests: XCTestCase {
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        
        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
        XCUIApplication().launch()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testCharityListView() {
        let app = XCUIApplication()
        let activityIdicator = app.activityIndicators["In progress"]
        XCTAssertTrue(activityIdicator.exists)  //assert if initial loading is shown
        
        let title = app.staticTexts["Charities"]
        XCTAssertTrue(title.exists)     //assert if charitis vc is loaded
        
        let tables = app.tables
        if tables.count > 0 {
            let tbl = tables.element(boundBy: 0)
            XCTAssertTrue(tbl.exists)       //assert if table exists
            
            expectation(for: NSPredicate(format: "count > 0"), evaluatedWith: tbl.cells, handler: nil)      //assert if cells exists
            waitForExpectations(timeout: 5.0, handler: nil)
        }else{
            XCTFail("Cannot find a table")
            return
        }
    }
    
    func testDonation() {
        let app = XCUIApplication()

        let tables = app.tables
        if tables.count > 0 {
            let tbl = tables.element(boundBy: 0)
            XCTAssertTrue(tbl.exists)
            expectation(for: NSPredicate(format: "count > 0"), evaluatedWith: tbl.cells, handler: nil)

            waitForExpectations(timeout: 5.0, handler: nil)

            let cells = app.cells
            if cells.count > 0 {
                let topElement = cells.element(boundBy: 0)
                topElement.tap()
            }

            let donationTextField = app.textFields["Donation amount"]
            XCTAssertTrue(donationTextField.exists)     //assert if screen moved to donation vc

            donationTextField.tap()
            donationTextField.typeText("asd")
            app.buttons["Next:"].tap()
            
            let toastMsg = app.staticTexts["Please enter valid amount!!!"]
            XCTAssertTrue(toastMsg.exists)  //assert if inavlid amount toast shown

            donationTextField.tap()

            guard let stringValue = donationTextField.value as? String else {
                XCTFail()
                return
            }
            for _ in stringValue{
                 app.keys["delete"].tap()
             }

            donationTextField.typeText("123")
            app.buttons["Next:"].tap()

            let scrollViewsQuery = app.scrollViews
            let cardField = scrollViewsQuery.children(matching: .textField).element(boundBy: 0)
            let nameField = scrollViewsQuery.children(matching: .textField).element(boundBy: 1)
            let expiryField = scrollViewsQuery.children(matching: .textField).element(boundBy: 2)
            let ccvField = scrollViewsQuery.children(matching: .textField).element(boundBy: 3)
                        
            cardField.tap()
            cardField.typeText("5555555555554444")
            
            nameField.tap()
            nameField.typeText("test name")
            
            expiryField.tap()
            expiryField.typeText("0223")
            
            ccvField.tap()
            ccvField.typeText("111")
            
            let payButton = app.buttons["Pay"]
            payButton.tap()
            
            // testing of Omise sdk is avoided for the flow
            
            let title = app.staticTexts["Donation successful"]
            expectation(for: NSPredicate(format: "exists == 1"), evaluatedWith: title, handler: nil)        //assert if screen moved to donation success vc

            waitForExpectations(timeout: 5.0, handler: nil)

            app.buttons["Back to charity List"].tap()
            XCTAssertTrue(app.staticTexts["Charities"].exists)      //assert if screen moved back to charities
        }else{
            XCTFail("Cannot find a table")
            return
        }
    }
    
    func testDummy() {
        
    }
    func testLaunchPerformance() {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTOSSignpostMetric.applicationLaunch]) {
                XCUIApplication().launch()
            }
        }
    }
}
