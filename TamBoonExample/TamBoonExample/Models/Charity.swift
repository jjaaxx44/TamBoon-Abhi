//
//  Charity.swift
//  TamBoonExample
//
//  Created by Abhishek Chaudhari on 07/01/20.
//  Copyright © 2020 Abhishek Chaudhari. All rights reserved.
//

import Foundation

struct Charity: Codable {
    let id: Int
    let name, logo_url: String?
}

struct CharityList: Codable {
    let data: [Charity]?
}
