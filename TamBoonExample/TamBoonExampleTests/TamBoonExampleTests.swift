//
//  TamBoonExampleTests.swift
//  TamBoonExampleTests
//
//  Created by Abhishek Chaudhari on 07/01/20.
//  Copyright © 2020 Abhishek Chaudhari. All rights reserved.
//

import XCTest
@testable import TamBoonExample

class TamBoonExampleTests: XCTestCase {
    let charity = Charity(id: 0, name: "testName", logo_url: "testUrl")
    let cellIdentifier = "CharityTableCell"

    func testCellContent() {
        let tableView = UITableView()
        tableView.register(UINib(nibName: "CharityTableCell", bundle: nil), forCellReuseIdentifier: cellIdentifier)
        let charityCell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as! CharityTableCell
        charityCell.charityObj = charity
        XCTAssertEqual(charityCell.charityNameLabel.text, "testName")
    }
}
