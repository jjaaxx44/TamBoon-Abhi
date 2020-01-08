//
//  DonationFormVC.swift
//  TamBoonExample
//
//  Created by Abhishek Chaudhari on 07/01/20.
//  Copyright © 2020 Abhishek Chaudhari. All rights reserved.
//

import UIKit
import OmiseSDK

class DonationFormVC: UIViewController {
    @IBOutlet weak var charityImageView: UIImageView!
    @IBOutlet weak var amountTextField: UITextField!
    private let charity: Charity!
    private let publicKey = "pkey_test_5ihexc8xj515r5di23o"

    // MARK: - View lifecycle
    init(charity: Charity) {
        self.charity = charity
        super.init(nibName: "DonationFormVC", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        updateViewContent()
    }
    // MARK: - view update
    func updateViewContent() {
        self.title = "Donation to " + (charity.name ?? "charity")
        guard let urlString = charity.logo_url,
            let url = URL(string: "\(urlString)") else {
                return
        }
        self.charityImageView.kf.setImage(with: url, placeholder: UIImage(named: "noimage"),options: [.transition(.fade(0.2))])
    }
    
    // MARK: - Actions
    func makeDonation(token: Token) {
        self.view.makeToastActivity(.center)
        self.view.isUserInteractionEnabled = false
        self.navigationItem.hidesBackButton = true
        guard let name = token.card.name,
            let amountString = amountTextField.text,
            let amount = Double(amountString) else {
            return
        }
        APIManager.shared.donateTo(id: charity.id, amount: amount, name: name, token: token.id) { result in
            switch result{
            case .success(_):
                Timer.scheduledTimer(withTimeInterval: 3.0, repeats: false) { (timer) in
                    self.view.hideToastActivity()
                    self.navigationItem.hidesBackButton = false
                    let donationSuccessVC = DonationSuccessVC(charity: self.charity)
                    self.navigationController?.pushViewController(donationSuccessVC, animated: true)
                }
            case .failure(let err):
                switch err {
                case .apiFailed, .donationFailed, .invalidInput:
                    self.view.makeToast("Donation failed!")
                default:
                    self.view.makeToast("Something went wrong!")
                }
                self.view.hideToastActivity()
                self.view.isUserInteractionEnabled = true
                self.navigationItem.hidesBackButton = false
            }
        }
    }
}

extension DonationFormVC: UITextFieldDelegate, CreditCardFormViewControllerDelegate {
    
    // MARK: - textField delegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        guard let text = textField.text else {
            return false
        }
        
        if text.isValidAmount {
            let creditCardView = CreditCardFormViewController.makeCreditCardFormViewController(withPublicKey: publicKey)
            creditCardView.delegate = self
            creditCardView.handleErrors = true
            present(creditCardView, animated: true, completion: nil)
        } else {
            self.view.makeToast("Please enter valid amount!!!")
        }
        return true
    }
    
    // MARK: - CC form delegate
    func creditCardFormViewController(_ controller: CreditCardFormViewController, didSucceedWithToken token: Token) {
        self.dismiss(animated: true, completion: nil)
        makeDonation(token: token)
        // Sends `Token` to your server to create a charge, or a customer object.
    }
    
    func creditCardFormViewController(_ controller: CreditCardFormViewController, didFailWithError error: Error) {
        self.dismiss(animated: true, completion: nil)
        
        // Only important if we set `handleErrors = false`.
        // You can send errors to a logging service, or display them to the user here.
    }
    func creditCardFormViewControllerDidCancel(_ controller: CreditCardFormViewController) {
        self.dismiss(animated: true, completion: nil)
    }
}
