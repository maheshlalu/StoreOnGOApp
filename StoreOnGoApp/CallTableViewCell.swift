//
//  CallTableViewCell.swift
//  StoreOnGoApp
//
//  Created by Manishi on 12/21/16.
//  Copyright © 2016 CX. All rights reserved.
//

import UIKit

class CallTableViewCell: UITableViewCell {

    @IBOutlet weak var callBtn: UIButton!
    @IBOutlet weak var smsBtn: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
