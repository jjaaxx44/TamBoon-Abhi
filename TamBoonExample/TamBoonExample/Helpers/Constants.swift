//
//  Constants.swift
//  TamBoonExample
//
//  Created by Abhishek Chaudhari on 07/01/20.
//  Copyright © 2020 Abhishek Chaudhari. All rights reserved.
//

import Foundation

struct TamboonAPI {
    private static let base = "https://virtserver.swaggerhub.com/jjaaxx44/Tamboon-abhi/1.0.0"
    private struct Path {
        static let charities = "/charities"
        static let donations = "/donations"
    }
    static let charitiesEndpoint = base + Path.charities
    static let donationsEndpoint = base + Path.donations
}

struct APIParameters {
    static let name = "name"
    static let charityId = "charityId"
    static let token = "token"
    static let amount = "amount"
}

enum GenralError: Error {
    case apiFailed
    case donationFailed
    case invalidInput
    case dataError
}
