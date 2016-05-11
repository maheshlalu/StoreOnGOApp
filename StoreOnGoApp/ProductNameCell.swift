//
//  ProductNameCell.swift
//  StoreOnGoApp
//
//  Created by Rama kuppa on 09/05/16.
//  Copyright © 2016 CX. All rights reserved.
//

import UIKit

class ProductNameCell: UICollectionViewCell {
    
    var textLabel: UILabel!

    override init(frame: CGRect) {
        super.init(frame: frame)
    
    let textFrame = CGRect(x: 0, y: 0, width: 100, height: 50)
    
    textLabel = UILabel(frame: textFrame)
    textLabel.font = UIFont.systemFontOfSize(UIFont.smallSystemFontSize())
    textLabel.textAlignment = .Center
    textLabel.font = UIFont.boldSystemFontOfSize(10)
   // contentView.addSubview(textLabel)
    //textLabel.text = "Mahesh Babu with muragadash"
    textLabel.textColor = UIColor.whiteColor()
    textLabel.backgroundColor = CXConstant.collectionCellBgColor
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
