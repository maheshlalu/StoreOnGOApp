//
//  ProductHeaderCell.swift
//  StoreOnGoApp
//
//  Created by Rama kuppa on 03/05/16.
//  Copyright © 2016 CX. All rights reserved.
//

import UIKit

class ProductHeaderCell: UITableViewCell {
    
    var bgView : UIView = UIView()
    var headerLbl: UILabel = UILabel()
    var detailCollectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    override init(style : UITableViewCellStyle, reuseIdentifier:String?){
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.addSubview(self.createLabel(CXConstant.itemCodeLblFrame, titleString: "ITEM CODE"))
        self.addSubview(self.createLabel(CXConstant.itemNameLblFrame, titleString: "ITEM NAME"))
        self.addSubview(self.createLabel(CXConstant.itemQuantityFrame, titleString: "QUANTITY"))
        self.addSubview(self.createLabel(CXConstant.itemtextFrame, titleString: ""))
        self.addSubview(self.createLabel(CXConstant.addtoCartFrame, titleString: "ADD TO CART"))

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        
    }
    
    func createLabel(frame:CGRect ,titleString:NSString) -> UILabel {
        
        let textFrame =  frame
        let  textLabel: UILabel = UILabel(frame: textFrame)
        textLabel.font = UIFont.systemFontOfSize(UIFont.smallSystemFontSize())
        textLabel.textAlignment = .Center
        textLabel.font = UIFont.boldSystemFontOfSize(10)
        textLabel.text = titleString as String
        textLabel.textColor = UIColor.whiteColor()
        textLabel.numberOfLines = 0
        textLabel.backgroundColor = CXConstant.collectionCellBgColor
        return textLabel
    }

   }
/*
 
 
 override init(frame: CGRect) {
 super.init(frame: frame)
 
 self.addSubview(self.createLabel(CXConstant.itemCodeLblFrame, titleString: "ITEM CODE"))
 self.addSubview(self.createLabel(CXConstant.itemNameLblFrame, titleString: "ITEM NAME"))
 self.addSubview(self.createLabel(CXConstant.itemQuantityFrame, titleString: "QUANTITY"))
 self.addSubview(self.createLabel(CXConstant.itemtextFrame, titleString: ""))
 self.addSubview(self.createLabel(CXConstant.addtoCartFrame, titleString: "ADD TO CART"))
 }
 
 required init?(coder aDecoder: NSCoder) {
 fatalError("init(coder:) has not been implemented")
 }
 
 
 
 func createLabel(frame:CGRect ,titleString:NSString) -> UILabel {
 
 let textFrame =  frame
 let  textLabel: UILabel = UILabel(frame: textFrame)
 textLabel.font = UIFont.systemFontOfSize(UIFont.smallSystemFontSize())
 textLabel.textAlignment = .Center
 textLabel.font = UIFont.boldSystemFontOfSize(10)
 contentView.addSubview(textLabel)
 textLabel.text = titleString as String
 textLabel.textColor = UIColor.whiteColor()
 textLabel.backgroundColor = CXConstant.collectionCellBgColor
 
 return textLabel
 }

 */