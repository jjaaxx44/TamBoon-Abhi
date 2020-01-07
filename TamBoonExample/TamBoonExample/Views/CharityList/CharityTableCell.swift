//
//  CharityTableCell.swift
//  TamBoonExample
//
//  Created by Abhishek Chaudhari on 07/01/20.
//  Copyright © 2020 Abhishek Chaudhari. All rights reserved.
//

import UIKit
import Kingfisher

class CharityTableCell: UITableViewCell {
    @IBOutlet weak var charityImageView: UIImageView!
    @IBOutlet weak var charityNameLabel: UILabel!
    
    var charityObj: Charity! {
        didSet {
            updateCellContent()
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        charityImageView.addBorder(borderWidth: 0.0, cornerRadius: 10.0, borderColor: .clear)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func updateCellContent() {
        self.charityNameLabel.text = charityObj.name
        self.charityImageView.kf.indicatorType = .activity
        
        guard let urlString = charityObj.logo_url,
            let url = URL(string: "\(urlString)") else {
            return
        }
        self.charityImageView.kf.setImage(with: url, placeholder: UIImage(named: "noimage"),options: [.transition(.fade(0.2))])

    }
}
