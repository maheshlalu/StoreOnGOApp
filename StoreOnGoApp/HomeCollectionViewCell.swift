//
//  HomeCollectionViewCell.swift
//  StoreOnGoApp
//
//  Created by Rama kuppa on 29/04/16.
//  Copyright © 2016 CX. All rights reserved.
//

import UIKit

class HomeCollectionViewCell: UICollectionViewCell {
    var titleLabel: UILabel!
    var iconImageView: UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.customizeMainView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func customizeMainView() {
        
        self.titleLabel = UILabel.init(frame: CGRectMake(50, 70, 150, 40))
        self.titleLabel.alpha = 0.7
        self.titleLabel.font = UIFont(name:"Roboto-Regular",size:15)
        self.titleLabel.textAlignment = NSTextAlignment.Center
        self.titleLabel.textColor = UIColor.whiteColor()
        self.addSubview(self.titleLabel)
    }
    
}
