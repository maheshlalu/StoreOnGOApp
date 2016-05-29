//
//  HeaderView.swift
//  StoreOnGoApp
//
//  Created by Rama kuppa on 01/05/16.
//  Copyright © 2016 CX. All rights reserved.
//

import UIKit

protocol DetailViewControllerDelegate: class {
    func didFinishTask(sender: HeaderView)
    //func cartButtonAction(sender: HeaderView)
}

class HeaderView: UIView {
    var btn: UIButton!
    let appLogo : UIImageView = UIImageView()

    weak var delegate:DetailViewControllerDelegate?

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    
    override init (frame : CGRect) {
        super.init(frame : frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
   
    class  func customizeHeaderView(cartButtonVisible:Bool,headerTitle:NSString,backButtonVisible : Bool) -> HeaderView {
        
        let appLogo = UIImageView(frame: CGRect(x: -120, y: 5, width: CXConstant.headerViewHeigh-2, height: CXConstant.headerViewHeigh-2))
        appLogo.contentMode = UIViewContentMode.Left
        // cellBackGroundView.addSubview(imageView)
        appLogo.image = UIImage(named: "appLogo")
        
        
        let headerView : HeaderView = HeaderView.init(frame: CGRectMake(0, 0, CXConstant.screenSize.width, CXConstant.headerViewHeigh))
        headerView.backgroundColor = UIColor.grayColor()
        let headerLbl : UILabel = UILabel.init(frame: CGRectMake(appLogo.frame.size.width+10, 0, CXConstant.screenSize.width-50, CXConstant.headerViewHeigh-2))
        headerLbl.text = headerTitle as String
        headerLbl.font = UIFont(name:"Roboto-Regular",size:13)
        headerLbl.textColor = UIColor.whiteColor()
        headerView.addSubview(headerLbl)
        
        headerLbl.addSubview(appLogo)
        
        let backButton = UIButton(frame: CGRect(x: 0, y: 0, width: 70, height: 70))
        backButton.backgroundColor = UIColor.greenColor()
        backButton.setTitle("Test Button", forState: UIControlState.Normal)
        backButton.addTarget(self, action: #selector(HeaderView.buttonAction(_:)), forControlEvents: UIControlEvents.TouchUpInside)

        if backButtonVisible {
            headerView.addSubview(backButton)
        }
        
        let cartBtn = MIBadgeButton()
        cartBtn.setImage(UIImage(named: "cart"), forState: .Normal)
        cartBtn.badgeString = "1"
        cartBtn.frame = CGRectMake(CXConstant.screenSize.width-60, 5, 40,40)
        cartBtn.addTarget(self, action: #selector(HeaderView.barButtonItemClicked(_:)), forControlEvents: .TouchUpInside)
        let item2 = UIBarButtonItem()
        item2.customView = cartBtn
        cartBtn.badgeEdgeInsets = UIEdgeInsetsMake(10, 10, 0, 15)
        cartBtn.badgeBackgroundColor = UIColor.whiteColor()
        cartBtn.badgeTextColor = UIColor.redColor()
        

        if cartButtonVisible {
            headerView.addSubview(cartBtn)

        }
        
        return headerView
    }
    
    func buttonAction(sender:UIButton!)
    {
        delegate?.didFinishTask(self)

        
    }
    
    func barButtonItemClicked(sender:UIButton!)
    {
        //delegate?.cartButtonAction(self)
        
        
    }
    
    func headerLabel () ->UILabel{
        
        let headerLbl : UILabel = UILabel.init(frame: CGRectMake(0, 0, CXConstant.screenSize.width, 70))
        return headerLbl
        
    }

}
    