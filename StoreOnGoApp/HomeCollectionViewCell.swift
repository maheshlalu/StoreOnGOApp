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
        
        self.iconImageView = UIImageView.init(frame: CGRectMake(0, 0, self.frame.width+7, self.frame.height))
        if (CXConstant.currentDeviceScreen() == IPHONE_6PLUS) {
            self.iconImageView = UIImageView.init(frame: CGRectMake(0, 0, self.frame.width+11, self.frame.height))
        }else if (CXConstant.currentDeviceScreen() == IPHONE_6) {
            self.iconImageView = UIImageView.init(frame: CGRectMake(0, 0, self.frame.width+10, self.frame.height))
        }
        self.iconImageView.center = CGPointMake(self.frame.width/2, self.frame.height/2)
        self.addSubview(self.iconImageView)

        /*
        self.titleLabel = UILabel.init(frame: CGRectMake(0, CXConstant.DetailCollectionCellSize.height-50, self.frame.size.width, 50))
        self.titleLabel.alpha = 0.7
        self.titleLabel.font = UIFont(name:"Roboto-Regular",size:12)
        self.titleLabel.textAlignment = NSTextAlignment.Center
        self.titleLabel.textColor = UIColor.whiteColor()
        self.addSubview(self.titleLabel)
 */
    }
    
}
