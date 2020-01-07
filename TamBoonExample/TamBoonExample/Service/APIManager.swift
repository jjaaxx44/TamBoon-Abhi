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
}
