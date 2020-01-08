//
//  APIManager.swift
//  TamBoonExample
//
//  Created by Abhishek Chaudhari on 07/01/20.
//  Copyright © 2020 Abhishek Chaudhari. All rights reserved.
//

import Foundation
import Alamofire

class APIManager {
    
    static let shared = APIManager()
    
    fileprivate init() { }
    
    //pageNumber and numebrOfCharities dont apply in current demo, but actual project shoud be implemented at server end
    func getCharities(pageNumber: Int = 0, numebrOfCharities: Int = 0, complition: @escaping (Swift.Result<[Charity], GenralError>) -> Void) {
        
        AF.request(TamboonAPI.charitiesEndpoint).responseJSON { (response) in
            switch response.result {
            case .success(_):
                do {
                    guard let charityData = response.data?.processData(classType: CharityList.self) as? CharityList else {
                        complition(.failure(.dataError))
                        return
                    }
                    complition(.success(charityData.data ?? []))
                }
            case .failure(_):
                complition(.failure(.apiFailed))
            }
        }
    }
    
    func donateTo(id: Int, amount: Double, name: String, token: String, complition: @escaping (Swift.Result<Bool, GenralError>) -> Void) {
        
        let parameters = [APIParameters.name: name,
                          APIParameters.charityId: id,
                          APIParameters.token: token,
                          APIParameters.amount: amount] as [String : Any]
        
        AF.request(TamboonAPI.donationsEndpoint, method: .post, parameters: parameters).responseJSON { (response) in
            switch response.result {
            case .success(let value):
                do {
                    guard let responceDict = value as? NSDictionary,
                        let didSucceed = responceDict.value(forKey: "success") as? Bool else {
                        complition(.failure(.dataError))
                        return
                    }
                    if response.response?.statusCode == 400 {
                        complition(.failure(.invalidInput))
                    } else {
                        if didSucceed {
                            complition(.success(true))
                        } else {
                            complition(.failure(.donationFailed))
                        }
                    }
                }
            case .failure(_):
                complition(.failure(.apiFailed))
            }
        }
        
    }
}
