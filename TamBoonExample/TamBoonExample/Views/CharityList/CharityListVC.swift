//
//  CharityListVC.swift
//  TamBoonExample
//
//  Created by Abhishek Chaudhari on 07/01/20.
//  Copyright © 2020 Abhishek Chaudhari. All rights reserved.
//

import UIKit
import Toast_Swift

class CharityListVC: UIViewController {
    
    @IBOutlet weak var charityTabelView: UITableView!
    private let refreshControl = UIRefreshControl()
    let cellIdentifier = "CharityTableCell"
    
    var charities: [Charity] = [] {
        didSet {
            if isViewLoaded {
                charityTabelView.reloadData()
            }
        }
    }
    // MARK: - view setup and actions
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupView()
        fetchCharities()
    }
    
    func setupView() {
        self.title = "Charities"
        charityTabelView.register(UINib(nibName: "CharityTableCell", bundle: nil), forCellReuseIdentifier: cellIdentifier)
        charityTabelView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(refreshCharityList(_:)), for: .valueChanged)
    }
    
    @objc func refreshCharityList(_ sender: Any) {
        fetchCharities()
    }
    
    // MARK: - data fetch
    func fetchCharities() {
        if !refreshControl.isRefreshing {
            self.view.makeToastActivity(.center)
        }
        APIManager.shared.getCharities { result in
            switch result{
            case .success(let charities):
                self.charities = charities
            case .failure(_):
                self.view.makeToast("Something went wrong!")
            }
            self.refreshControl.endRefreshing()
            if !self.refreshControl.isRefreshing {
                self.view.hideToastActivity()
            }
        }
    }
}


// MARK: - table datasource and delegate
extension CharityListVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return charities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! CharityTableCell
        cell.charityObj = charities[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let donationVC = DonationFormVC(charity: charities[indexPath.row])
        self.navigationController?.pushViewController(donationVC, animated: true)
    }
}
