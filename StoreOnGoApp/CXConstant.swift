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


    static let tableViewHeigh : CGFloat = 280
    static let screenSize = UIScreen.mainScreen().bounds.size

    static let someString : String = "Some Text" // struct
    static let collectiViewCellSize :  CGSize = CGSize(width: UIScreen.mainScreen().bounds.size.width-20,height: tableViewHeigh-50)
    
    static let collectionViewFrame : CGRect = CGRectMake(8, 30, UIScreen.mainScreen().bounds.size.width-20, tableViewHeigh-50)
    
    static let titleLabelColor : UIColor = UIColor(red: 240.0/255.0, green: 40.0/255.0, blue: 0.0/255.0, alpha: 1.0)
    
    
    static let collectionCellborderColor : UIColor = UIColor(red: 191.0/255.0, green: 191.0/255.0, blue: 191.0/255.0, alpha: 1.0)
    
    static let collectionFram : CGRect = CGRectMake(0, 300,screenSize.width, screenSize.height-300)

    
    static let DetailTableView_Width = UIScreen.mainScreen().bounds.width-20
    static let DetailCollectionCellSize :  CGSize = CGSize(width: 190,height: tableViewHeigh-80)
    static let MallID = "4452"
    
        //CGSize(width: UIScreen.mainScreen().bounds.size.width-20,height: tableViewHeigh-50)
        
        ///
    
    static let DetailCollectionViewFrame : CGRect = CGRectMake(4, 30, DetailTableView_Width-8, tableViewHeigh-50)
        
        
        //CGRectMake(8, 30, UIScreen.mainScreen().bounds.size.width-20, tableViewHeigh-50)
        
        //
    
    
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
            print("JSON data is \(jsonData)")
            dataString = String(data: jsonData, encoding: NSUTF8StringEncoding)
            print("Converted JSON string is \(dataString)")
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

}
