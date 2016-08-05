//
//  ProductCollectionCell.swift
//  StoreOnGoApp
//
//  Created by Rama kuppa on 29/04/16.
//  Copyright © 2016 CX. All rights reserved.
//

import UIKit

class ProductCollectionCell: UICollectionViewCell {

    var textLabel: UILabel!
    var imageView: UIImageView!
    var cellBackGroundView : UIView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        cellBackGroundView = UIView(frame: CGRect(x: 0, y: 0, width: CXConstant.DetailCollectionCellSize.width, height: CXConstant.DetailCollectionCellSize.height))
        //contentView.addSubview(cellBackGroundView)
        cellBackGroundView.layer.cornerRadius = 1.0
        cellBackGroundView.layer.borderColor = CXConstant.collectionCellborderColor.CGColor
        cellBackGroundView.layer.borderWidth = 2.0
        
        imageView = UIImageView(frame: CGRect(x: 1, y: 1, width: frame.size.width-2, height: CXConstant.DetailCollectionCellSize.height-2))
        imageView.contentMode = UIViewContentMode.ScaleAspectFit
       // cellBackGroundView.addSubview(imageView)
        //imageView.image = UIImage(named: "sampleImage")
        imageView.contentMode = UIViewContentMode.ScaleToFill
        
        
       // let textFrame = CGRect(x: 2, y: CXConstant.DetailCollectionCellSize.height-40, width: CXConstant.DetailCollectionCellSize.width-2, height: 38)
        
        //CGSize(width:80,height:50)
        let textFrame = CGRect(x: 0, y: 0, width: CXConstant.ProductCollectionCellSize.width-2, height: 38)

        textLabel = UILabel(frame: textFrame)
        textLabel.font = UIFont(name:"Roboto-Regular",size:8)
        textLabel.textAlignment = .Center
        textLabel.numberOfLines = 0
        //textLabel.font = UIFont.boldSystemFontOfSize(10)
        contentView.addSubview(textLabel)
        //textLabel.text = "Mahesh Babu with muragadash"
        textLabel.textColor = UIColor.whiteColor()
        textLabel.backgroundColor = CXConstant.collectionCellBgColor

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
}
