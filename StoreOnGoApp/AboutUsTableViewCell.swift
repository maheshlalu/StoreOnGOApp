//
//  AboutUsTableViewCell.swift
//  StoreOnGoApp
//
//  Created by Manishi on 12/21/16.
//  Copyright © 2016 CX. All rights reserved.
//

import UIKit

class AboutUsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var templateImg: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var descriptionLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
