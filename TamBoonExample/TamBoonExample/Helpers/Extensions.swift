//
//  Extensions.swift
//  TamBoonExample
//
//  Created by Abhishek Chaudhari on 07/01/20.
//  Copyright © 2020 Abhishek Chaudhari. All rights reserved.
//

import UIKit

extension Data {
    func processData<T: Decodable>(classType: T.Type) -> Any? {
        do {
            let responceObj = try JSONDecoder().decode(classType, from: self)
            return responceObj
        }catch (let err){
            print(err)
            return nil
        }
    }
}

extension UIView {
    func addBorder(borderWidth: CGFloat, cornerRadius: CGFloat, borderColor: UIColor){
        self.layer.borderColor = borderColor.cgColor
        self.layer.borderWidth = borderWidth
        self.layer.cornerRadius = cornerRadius
    }
}

extension String {
    var isValidAmount: Bool {
        let regularExpressionForEmail = #"^(\d*\.)?\d+$"#
        let testEmail = NSPredicate(format:"SELF MATCHES %@", regularExpressionForEmail)
        return testEmail.evaluate(with: self)
    }
}
