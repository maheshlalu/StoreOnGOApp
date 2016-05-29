//
//  CartITemCell.swift
//  StoreOnGoApp
//
//  Created by Rama kuppa on 15/05/16.
//  Copyright © 2016 CX. All rights reserved.
//

import UIKit

class CartITemCell: UITableViewCell {
    var cartItemNameLbl : UILabel = UILabel()
    var quantityLbl : UILabel = UILabel()

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
        //self.backgroundColor = UIColor.whiteColor()
        self.backgroundView?.backgroundColor = UIColor.clearColor()
        self.backgroundColor = UIColor.clearColor()
        self.selectionStyle = UITableViewCellSelectionStyle.None
        self.designCartCellView()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func designCartCellView(){
        
        let cartBackgroundView : UIView = UIView.init(frame: CGRectMake(10, 5, CXConstant.screenSize.width-20, CXConstant.cartCellHeight-5))
        
        cartBackgroundView.layer.cornerRadius = 8.0
        cartBackgroundView.layer.borderWidth = 1.0
        cartBackgroundView.layer.borderColor = UIColor.grayColor().CGColor
        cartBackgroundView.backgroundColor = UIColor.whiteColor()
        self.contentView.addSubview(cartBackgroundView)

        self.cartItemNameLbl = CXConstant.sharedInstance.createLabel(CGRectMake(0, 0, cartBackgroundView.frame.size.width/2.5 , 35), titleString: "")

        
        self.quantityLbl = CXConstant.sharedInstance.createLabel(CGRectMake(self.cartItemNameLbl.frame.size.width+1, 0, cartBackgroundView.frame.size.width-self.cartItemNameLbl.frame.size.width-2, 35), titleString: "")
        
        self.quantityLbl.textColor = UIColor.redColor()
        cartBackgroundView.addSubview(self.cartItemNameLbl)
        cartBackgroundView.addSubview(self.quantityLbl)
        
    }
    


}
