//
//  CXDetailCollectionViewCell.swift
//  Silly Monks
//
//  Created by Sarath on 09/04/16.
//  Copyright © 2016 Sarath. All rights reserved.
//

import UIKit

class CXDetailCollectionViewCell: UICollectionViewCell {
    
    var infoLabel: UILabel!
    var detailImageView: UIImageView!
    var bgView : UIView = UIView()
    //var activity: DTIActivityIndicatorView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.customizeMainView()
    }
    
    func customizeMainView() {
        self.bgView.frame = CGRectMake(0, 0, CXConstant.DetailCollectionCellSize.width, CXConstant.DetailCollectionCellSize.height)
        self.bgView.backgroundColor = UIColor.whiteColor()
        //self.bgView.layer.cornerRadius = 1.0
        //self.bgView.layer.borderColor = CXConstant.collectionCellborderColor.CGColor
        //self.bgView.layer.borderWidth = 2.0
        
        self.detailImageView = UIImageView.init(frame: CGRectMake(0, 0, self.bgView.frame.size.width, self.bgView.frame.height))
        self.detailImageView.image = UIImage(named:"smlogo.png")
        self.bgView.addSubview(self.detailImageView)
        
        self.infoLabel = UILabel.init(frame: CGRectMake(0, self.detailImageView.frame.size.height-40, self.bgView.frame.size.width, 40))
        self.infoLabel.backgroundColor = UIColor.blackColor();
        self.infoLabel.alpha = 0.7
        self.infoLabel.font = UIFont(name:"Roboto-Regular",size:15)
        self.infoLabel.textAlignment = NSTextAlignment.Center
        self.infoLabel.textColor = UIColor.whiteColor()
        
        self.bgView.addSubview(self.infoLabel)
        
        
       // self.activity = DTIActivityIndicatorView(frame: CGRect(x:(self.bgView.frame.size.width - 60)/2, y:(self.bgView.frame.size.height - 60)/2, width:60.0, height:60.0))
        //self.bgView.addSubview(self.activity)


        self.addSubview(self.bgView)
        
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
