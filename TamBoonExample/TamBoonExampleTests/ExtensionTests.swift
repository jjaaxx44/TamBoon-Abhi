//
//  ExtensionTests.swift
//  TamBoonExampleTests
//
//  Created by Abhishek Chaudhari on 07/01/20.
//  Copyright © 2020 Abhishek Chaudhari. All rights reserved.
//

import XCTest
@testable import TamBoonExample

let correctJson = #"{ "id" : 0, "name" : "dummyname", "logo_url" : "dummyurl"}"#
let wrongJson = #"{ "id1" : 0, "name1" : "dummyname", "logo_url1" : "dummyurl"}"#

class ExtensionTests: XCTestCase {

    func testViewBorder() {
        let border: CGFloat = 10.0
        let cornerRadius: CGFloat = 1.0
        let borderColor = UIColor.white
        
        let view = UIView()
        view.addBorder(borderWidth: border, cornerRadius: cornerRadius, borderColor: borderColor)
        
        XCTAssertTrue(view.layer.borderWidth == border)
        XCTAssertTrue(view.layer.cornerRadius == cornerRadius)
        
        let approximateColor = borderColor.cgColor.converted(to: (view.layer.borderColor?.colorSpace!)!, intent: .defaultIntent, options: nil)
        XCTAssertTrue(view.layer.borderColor == approximateColor)
    }
    
    func testProcessData() {
        let correctData = correctJson.data(using: .utf8)!
        let wrongData = wrongJson.data(using: .utf8)!

        let charityCorrect = correctData.processData(classType: Charity.self) as? Charity
        
        XCTAssertEqual(charityCorrect?.name, "dummyname")
        XCTAssertEqual(charityCorrect?.id, 0)
        XCTAssertEqual(charityCorrect?.logo_url, "dummyurl")
        
        let charityWrong = wrongData.processData(classType: Charity.self) as? Charity
        XCTAssertNil(charityWrong)
    }


}
