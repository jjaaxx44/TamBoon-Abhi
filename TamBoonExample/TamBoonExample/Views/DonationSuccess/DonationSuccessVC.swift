//
//  DonationSuccessVC.swift
//  TamBoonExample
//
//  Created by Abhishek Chaudhari on 08/01/20.
//  Copyright © 2020 Abhishek Chaudhari. All rights reserved.
//

import UIKit

class DonationSuccessVC: UIViewController {
    @IBOutlet weak var successLabel: UILabel!

    private let charity: Charity!

    // MARK: - View lifecycle
    init(charity: Charity) {
        self.charity = charity
        super.init(nibName: "DonationSuccessVC", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupView()
        updateViewContent()
    }
    
    func setupView() {
        self.navigationItem.hidesBackButton = true
    }
    
    // MARK: - view update
    func updateViewContent() {
        self.title = "Donation successful"
        successLabel.text = "Thank you for donating to " + (charity.name ?? "charity")
    }
    
    // MARK: - Actions
    @IBAction func charityListClicked(_ sender: Any) {
        navigationController?.popToRootViewController(animated: true)
    }
}
