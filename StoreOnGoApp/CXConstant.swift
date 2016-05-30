//
//  CXconstant.swift
//  SampleSwiftTable
//
//  Created by Rama kuppa on 27/03/16.
//  Copyright © 2016 Sarath. All rights reserved.
//

import UIKit

private var _SingletonSharedInstance:CXConstant! = CXConstant()

class CXConstant: NSObject {
    
    class var sharedInstance : CXConstant {
        return _SingletonSharedInstance
    }
    
    private override init() {
        
    }
    
    func destory () {
        _SingletonSharedInstance = nil
    }
    
    //MARK :
    static let screenSize = UIScreen.mainScreen().bounds.size
    
    static let headerViewHeigh : CGFloat = 65
    
    
    static let pagerHeight : CGFloat = screenSize.height/3
    static let cartCellHeight : CGFloat = 50
    static let segmentFrame : CGRect = CGRectMake(0, headerViewHeigh, CXConstant.screenSize.width, 35)
    static let searchBarFrame : CGRect = CGRectMake(0, segmentFrame.origin.y+segmentFrame.size.height+1, UIScreen.mainScreen().bounds.size.width, headerViewHeigh-20)
    static let pagerFrame : CGRect = CGRectMake(0, headerViewHeigh+2, UIScreen.mainScreen().bounds.size.width, pagerHeight)
    static let collectionFram : CGRect = CGRectMake(0, pagerHeight+pagerFrame.origin.y,screenSize.width, screenSize.height-pagerHeight-headerViewHeigh)
    
    static let homeCellBgColor : UIColor = UIColor(red: 236.0/255.0, green: 50.0/255.0, blue: 55.0/255.0, alpha: 1.0)
    
    //MARK :
    //2.15
    static let tableViewHeigh : CGFloat = 280
    
    static let someString : String = "Some Text" // struct
    //static let collectiViewCellSize :  CGSize = CGSize(width: UIScreen.mainScreen().bounds.size.width-20,height: tableViewHeigh-50)
    
    static let collectionViewFrame : CGRect = CGRectMake(8, 30, UIScreen.mainScreen().bounds.size.width-20, tableViewHeigh-50)
    
    static let titleLabelColor : UIColor = UIColor(red: 240.0/255.0, green: 40.0/255.0, blue: 0.0/255.0, alpha: 1.0)
    
    static let collectionCellborderColor : UIColor = UIColor(red: 190.0/255.0, green: 210.0/255.0, blue: 220.0/255.0, alpha: 1.0)
    ///211,41,39
    static let collectionCellBgColor : UIColor = UIColor(red: 211.0/255.0, green: 41.0/255.0, blue: 39.0/255.0, alpha: 1.0)
    
    //67,67,67
    
    static let keepShoppingBtnColor : UIColor = UIColor(red: 67.0/255.0, green: 67.0/255.0, blue: 67.0/255.0, alpha: 1.0)
    static let checkOutBtnColor : UIColor = UIColor(red: 212.0/255.0, green: 56.0/255.0, blue: 56.0/255.0, alpha: 1.0)
    static let cartViewBgClor : UIColor = UIColor(red: 242.0/255.0, green: 242.0/255.0, blue: 242.0/255.0, alpha: 1.0)

    
    
    static let DetailTableView_Width = UIScreen.mainScreen().bounds.width-20
    static let DetailCollectionCellSize :  CGSize = CGSize(width: screenSize.width/2.3+5,height: screenSize.width/2.3+5)
    
    static let ProductCollectionCellSize :  CGSize = CGSize(width:screenSize.width/3.455555,height: 40)

    // static let DetailCollectionCellSize :  CGSize = CGSize(width: 150,height: 150)
    
    static let MallID = "4452"
    
    //CGSize(width: UIScreen.mainScreen().bounds.size.width-20,height: tableViewHeigh-50)        ///
    
    static let DetailCollectionViewFrame : CGRect = CGRectMake(4, 30, DetailTableView_Width-8, tableViewHeigh-50)
    
    //MARK:
    
    static let itemCodeLblFrame : CGRect = CGRectMake(0, 0, screenSize.width/6-1, 50) //8.28
    
    static let itemNameLblFrame : CGRect = CGRectMake(itemCodeLblFrame.size.width+1, 0,screenSize.width/3.18, 50) //3.18
    
    static let itemQuantityFrame : CGRect = CGRectMake(itemNameLblFrame.size.width+1+itemNameLblFrame.origin.x, 0, screenSize.width/7, 50)//8.28
    
    static let itemtextFrame : CGRect = CGRectMake(itemQuantityFrame.size.width+1+itemQuantityFrame.origin.x, 0, screenSize.width/7, 50)//8.28

    static let addtoCartFrame : CGRect = CGRectMake(itemtextFrame.size.width+1+itemtextFrame.origin.x, 0, screenSize.width/4.5+1, 50) //3.18
    /*
     iPhone 6s plus
     - width : 414.0
     - height : 736.0
     */
    
    
    //MARK:
    
    
    //CGRectMake(8, 30, UIScreen.mainScreen().bounds.size.width-20, tableViewHeigh-50)
    
    static let HOME_BANNAER = "/133516651/AppHome"
    static let TOLLYWOOD_BANNAER = "/133516651/AppTollyBanner"
    static let BOLLYWOOD_BANNAER = "/133516651/AppBollyBanner"
    static let HOLLYWOOD_BANNAER = "/133516651/AppHollyBanner"
    static let KOLLYWOOD_BANNAER = "/133516651/AppKollyBanner"
    static let MOLLYWOOD_BANNAER = "/133516651/AppMollyBanner"
    static let SANDALWOOD_BANNAER = "/133516651/AppSandalBanner"
    
    
    // BrightCove Directives
    
    let kViewControllerPlaybackServicePolicyKey = "BCpkADawqM1Sh_RsWQTEtCCpMbpKrbKQN_lhGY3fSZE-Cbp67h2aDRTDuifFXnT3yEYrxPNy640VTr224uWjtky-6YDzzqIDRyjqZq_wXu4Py0MSUMdf2rPmS102D6QGi8bIEQEXutS-eeVp"
    let kViewControllerAccountID = "3636334180001"
    let kViewControllerVideoID = "3987127390001"
    
    
    
    // Sevices URLs
    
    static let PRODUCT_CATEGORY_URL = "http://storeongo.com:8081/Services/getMasters?type=productCategories&mallId="
    static let STORES_URL = "http://storeongo.com:8081/Services/getMasters?type=stores&mallId="
    static let FEATUREDPRODUCT_URL = "http://storeongo.com:8081/Services/getMasters?type=featured%20products&mallId="
    
    
    static let addToCartItemUrl = "http://storeongo.com:8081/MobileAPIs/postedJobs?type=PlaceOrder&json="
    
    
    
    //%@&dt=CAMPAIGNS&category=Services&userId=%@&consumerEmail=%@"

    //http://storeongo.com:8081/Services/getMasters?type=productCategories&mallId=4452
    
    
    
    
    
    func productURL(productType:String, mallId: String) -> String {
        let escapedString = productType.stringByAddingPercentEncodingWithAllowedCharacters(.URLHostAllowedCharacterSet())
        let reqString = "http://52.74.102.199:8081/services/getmasters?type="+escapedString!+"&mallId="+mallId
        return reqString
    }
    
    func resultString(input: AnyObject) -> String{
        var reqType : String!
        
        switch input {
        case let i as NSNumber:
            reqType = "\(i)"
        case let s as NSString:
            reqType = "\(s)"
        default:
            reqType = "Invalid Format"
        }
        
        return reqType
    }
    
    func convertDictionayToString(dictionary:NSDictionary) -> NSString {
        var dataString: String!
        do {
            let jsonData = try NSJSONSerialization.dataWithJSONObject(dictionary, options: NSJSONWritingOptions.PrettyPrinted)
            //print("JSON data is \(jsonData)")
            dataString = String(data: jsonData, encoding: NSUTF8StringEncoding)
           // print("Converted JSON string is \(dataString)")
            // here "jsonData" is the dictionary encoded in JSON data
        } catch let error as NSError {
            dataString = ""
            print(error)
        }
        return dataString
    }
    
    func convertStringToDictionary(string:String) -> NSDictionary {
        var jsonDict : NSDictionary = NSDictionary()
        let data = string.dataUsingEncoding(NSUTF8StringEncoding)
        do {
            jsonDict = try NSJSONSerialization.JSONObjectWithData(data!, options:NSJSONReadingOptions.MutableContainers ) as! NSDictionary            // CXDBSettings.sharedInstance.saveAllMallsInDB((jsonData.valueForKey("orgs") as? NSArray)!)
        } catch {
            print("Error in parsing")
        }
        return jsonDict
    }
    
    func createLabel(frame:CGRect ,titleString:NSString) -> UILabel {
        
        let textFrame =  CGRectMake(frame.origin.x, frame.origin.y+5, frame.size.width, frame.size.height+20)
        let  textLabel: UILabel = UILabel(frame: textFrame)
        //textLabel.font = UIFont.systemFontOfSize(UIFont.smallSystemFontSize())
        textLabel.textAlignment = .Center
        textLabel.font = UIFont(name:"Roboto-Regular",size:8)
        //textLabel.font = UIFont.boldSystemFontOfSize(10.0)
        textLabel.text = titleString as String
        textLabel.textColor = UIColor.blackColor()
        textLabel.numberOfLines = 0
    
        //textLabel.sizeToFit()
        return textLabel
    }
    
    func CrateButton(frame:CGRect , titleString : NSString ,backGroundColor : UIColor, font : UIFont) -> UIButton {
        
        let button   = UIButton.init() as UIButton
        button.frame = frame // CGRectMake(frame.origin.x, 15, frame.size.width-5, 25)
        button.backgroundColor = backGroundColor
        button.setTitle(titleString as String, forState: UIControlState.Normal)
        button.titleLabel?.font = font
        //button.addTarget(self, action: #selector(ProductListCntl.addToCartButton(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        button.layer.cornerRadius = 1.0
        button.layer.borderWidth = 2.0
        button.layer.borderColor = UIColor.whiteColor().CGColor
        button.showsTouchWhenHighlighted = true
        return button
        
    }
    
}
