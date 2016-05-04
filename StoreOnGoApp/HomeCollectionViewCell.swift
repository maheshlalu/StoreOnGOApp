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
        self.backgroundColor = CXConstant.homeCellBgColor
        self.customizeMainView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func customizeMainView() {
        
        //self.iconImageView = UIImageView.init(frame: CGRectMake(self.frame.origin.x+10, self.frame.origin.y+10, 100, 100))
        self.iconImageView = UIImageView.init(frame: CGRectMake(0, 0, 70, 70))
        self.iconImageView.center = CGPointMake(self.frame.width/2, self.frame.height/2)
        self.addSubview(self.iconImageView)

        self.titleLabel = UILabel.init(frame: CGRectMake(0, self.frame.height-100, self.frame.size.width, self.frame.height-70))
        self.titleLabel.alpha = 0.7
        self.titleLabel.font = UIFont(name:"Roboto-Regular",size:15)
        self.titleLabel.textAlignment = NSTextAlignment.Center
        self.titleLabel.textColor = UIColor.whiteColor()
        self.addSubview(self.titleLabel)
    }
    
}
