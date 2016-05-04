//
//  CX_AppData.swift
//  StoreOnGoApp
//
//  Created by Rama kuppa on 30/04/16.
//  Copyright © 2016 CX. All rights reserved.
//

import UIKit
protocol AppDataDelegate {
    func completedTheFetchingTheData(sender: CX_AppData)

}

private var _SingletonSharedInstance:CX_AppData! = CX_AppData()

class CX_AppData: NSObject {
    

    private var appDelegate:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    
     var dataDelegate:AppDataDelegate?

    class var sharedInstance : CX_AppData {
        return _SingletonSharedInstance
    }
    
    func destory () {
        _SingletonSharedInstance = nil
    }
    
    func getStoresData(){
        let reqUrl = CXConstant.STORES_URL + CXConstant.MallID
        SMSyncService.sharedInstance.startSyncProcessWithUrl(reqUrl) { (responseDict) -> Void in
            // print ("stores   response   data \(responseDict.valueForKey("jobs")! as! NSArray) ")
            CXDBSettings.sharedInstance.saveStoresInDB(responseDict.valueForKey("jobs")! as! NSArray)
            self.getProductCategory()
        }
    }
    
    func getProductCategory(){
        
        let reqUrl = CXConstant.PRODUCT_CATEGORY_URL + CXConstant.MallID
        SMSyncService.sharedInstance.startSyncProcessWithUrl(reqUrl) { (responseDict) -> Void in
            print ("Product category response \(responseDict)")
             CXDBSettings.sharedInstance.saveProductCategoriesInDB(responseDict.valueForKey("jobs")! as! NSArray)
            self.getFeaturedProducts()
        }

    }
    
    func getFeaturedProducts(){

        let reqUrl = CXConstant.FEATUREDPRODUCT_URL + CXConstant.MallID
        SMSyncService.sharedInstance.startSyncProcessWithUrl(reqUrl) { (responseDict) -> Void in
            print ("Featured Product  response \(responseDict)")
            CXDBSettings.sharedInstance.saveFeaturedProducts(responseDict.valueForKey("jobs")! as! NSArray)
        }
        dispatch_async(dispatch_get_main_queue(), {
            self.dataDelegate?.completedTheFetchingTheData(self)
        })
     //self.parseTheProductsList()
    }
    
    
    func parseTheProductsList(){
        
        
        
    }
}

