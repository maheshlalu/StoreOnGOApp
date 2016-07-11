//
//  StickerDetailCell.swift
//  StoreOnGoApp
//
//  Created by Rama kuppa on 09/07/16.
//  Copyright © 2016 CX. All rights reserved.
//

import UIKit

class StickerDetailCell: UICollectionViewCell {

    @IBOutlet var itemNameLbl: UILabel!
    @IBOutlet var addToCartBtn: UIButton!
    @IBOutlet var quantityTxt: UITextField!
    @IBOutlet var itemCodeLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.addToCartBtn.layer.cornerRadius = 8.0
        self.addToCartBtn.layer.borderColor = UIColor.grayColor().CGColor
        self.addToCartBtn.layer.borderWidth = 2.0
        self.addToCartBtn.layer.masksToBounds = true
    }

}
