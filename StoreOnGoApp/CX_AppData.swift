//
//  CX_AppData.swift
//  StoreOnGoApp
//
//  Created by Rama kuppa on 30/04/16.
//  Copyright © 2016 CX. All rights reserved.
//

import UIKit
//protocol AppDataDelegate {
//    func completedTheFetchingTheData(sender: CX_AppData)
//    
//}

private var _SingletonSharedInstance:CX_AppData! = CX_AppData()

class CX_AppData: NSObject {
    
    
    private var appDelegate:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
   // var dataDelegate:AppDataDelegate?
    
    class var sharedInstance : CX_AppData {
        return _SingletonSharedInstance
    }
    
    func destory () {
        _SingletonSharedInstance = nil
    }
    
    func getStoresData(){
        
        

        //self.configure()
        //LoadingView.show("Loading", animated: true)

        let reqUrl = CXConstant.STORES_URL + CXConstant.MallID
        SMSyncService.sharedInstance.startSyncProcessWithUrl(reqUrl) { (responseDict) -> Void in
            // print ("stores   response   data \(responseDict.valueForKey("jobs")! as! NSArray) ")
            CXDBSettings.sharedInstance.saveStoresInDB(responseDict.valueForKey("jobs")! as! NSArray)
        }
        
            self.parseTheProductSubCategory()
        
    }
    
    
    
    func getProductCategory(){
        
        let reqUrl = CXConstant.PRODUCT_CATEGORY_URL + CXConstant.MallID
        SMSyncService.sharedInstance.startSyncProcessWithUrl(reqUrl) { (responseDict) -> Void in
           // print ("Product category response \(responseDict)")
            CXDBSettings.sharedInstance.saveProductCategoriesInDB(responseDict.valueForKey("jobs")! as! NSArray)
        }
            self.getFeaturedProducts()
        
    }
    
    func getFeaturedProducts(){
        
        let reqUrl = CXConstant.FEATUREDPRODUCT_URL + CXConstant.MallID
        SMSyncService.sharedInstance.startSyncProcessWithUrl(reqUrl) { (responseDict) -> Void in
           // print ("Featured Product  response \(responseDict)")
            CXDBSettings.sharedInstance.saveFeaturedProducts(responseDict.valueForKey("jobs")! as! NSArray)
        }
        dispatch_async(dispatch_get_global_queue(QOS_CLASS_BACKGROUND, 0), {
            self.parseTheProductsList()
        })
    }
    
    func parseTheProductsList(){
        
       // LoadingView.show("ProductList Loading....", animated: true)
       // let fetchRequest = NSFetchRequest(entityName: "CX_Products")
     //   if    CX_Products.MR_executeFetchRequest(fetchRequest).count == 0 {
            dispatch_async(dispatch_get_global_queue(QOS_CLASS_BACKGROUND, 0), {
                //call your background operation.
                let dataDic : NSDictionary = self.getTheDictionaryDataFromTextFile("productslist")
                if (dataDic.valueForKey("jobs") != nil) {
                    CXDBSettings.sharedInstance.saveProductsInDB(dataDic.valueForKey("jobs")! as! NSArray, typeCategory: "Products List")
                }
            })
        
        dispatch_async(dispatch_get_global_queue(QOS_CLASS_BACKGROUND, 0), {
            self.miscellaneousList()
        })
//        }else{
//            dispatch_async(dispatch_get_main_queue(), {
//                LoadingView.hide()
//            })
//        }
    }
    
    func miscellaneousList(){
       // LoadingView.show("Miscellaneous Loading....", animated: true)
            CXDBSettings.sharedInstance.saveProductsInDB(self.getTheDictionaryDataFromTextFile("miscellaneous").valueForKey("jobs")! as! NSArray, typeCategory: "Miscellaneous")
        dispatch_async(dispatch_get_global_queue(QOS_CLASS_BACKGROUND, 0), {
            self.parseStickersList()
        })
        
    }
    
    func parseStickersList(){
        
         CXDBSettings.sharedInstance.saveProductsInDB(self.getTheDictionaryDataFromTextFile("sticker").valueForKey("jobs")! as! NSArray, typeCategory: "sticker")
    }
    
    func parseTheProductSubCategory(){
        //LoadingView.show("Subcategory Loading....", animated: true)
        let fetchRequest = NSFetchRequest(entityName: "TABLE_PRODUCT_SUB_CATEGORIES")
        if    TABLE_PRODUCT_SUB_CATEGORIES.MR_executeFetchRequest(fetchRequest).count == 0 {
            dispatch_async(dispatch_get_global_queue(QOS_CLASS_BACKGROUND, 0), {
                //call your background operation.
                let dataDic : NSDictionary = self.getTheDictionaryDataFromTextFile("subcate")
                if (dataDic.valueForKey("jobs") != nil) {
                    CXDBSettings.sharedInstance.savetheSubCategoryData(dataDic.valueForKey("jobs")! as! NSArray)
                }
            })
        }else{
           
        }

        dispatch_async(dispatch_get_global_queue(QOS_CLASS_BACKGROUND, 0), {
        self.getProductCategory()
        })
    }
    
    func getTheDictionaryDataFromTextFile(testFileName:String)-> NSDictionary{
        
        let path = NSBundle.mainBundle().pathForResource(testFileName, ofType: "txt")
        let text = NSData(contentsOfFile: path!)
        
        do {
            let JSON = try NSJSONSerialization.JSONObjectWithData(text!, options:NSJSONReadingOptions(rawValue: 0))
            guard let JSONDictionary :NSDictionary = JSON as? NSDictionary else {
                print("Not a Dictionary")
                // put in function
                return NSDictionary()
            }
          //  print("JSONDictionary! \(JSONDictionary.valueForKey("jobs"))")
            return JSONDictionary
        }
        catch let JSONError as NSError {
            print("\(JSONError)")
        }
        return NSDictionary()
    }
    
     func configure (){
        var config : LoadingView.Config = LoadingView.Config()
        config.size = 170
        config.backgroundColor = UIColor.whiteColor() //UIColor(red:0.03, green:0.82, blue:0.7, alpha:1)
        config.spinnerColor = UIColor(red:0.88, green:0.26, blue:0.18, alpha:1)
        config.titleTextColor = UIColor(red:0.88, green:0.26, blue:0.18, alpha:1)
        config.spinnerLineWidth = 2.0
        config.foregroundColor = UIColor.blackColor()
        config.foregroundAlpha = 0.5
        LoadingView.setConfig(config)
    }
    
}



/*
 when click on stickers get tha data using "select * from ZTABLE_PRODUCT_SUB_CATEGORIES where ZMASTERCATEGORY = 'Sticker(139455)'" query
 
 
 click on sticker item check the contain string in colomn "SubCategory" (with ZNAME = KICK ASSY() in ZTABLE_PRODUCT_SUB_CATEGORIES) in  TABLE_PRODUCT_3RDLEVEL_CATEGORIES

 
 
 
 select * from ZCX_PRODUCTS where ZP3RDCATEGORY = 'STICKER SET(140138)**( Name+id append in TABLE_PRODUCT_3RDLEVEL_CATEGORIES)**' 
 
 and ZSUBCATNAMEID = (with ZNAME = KICK ASSY() in ZTABLE_PRODUCT_SUB_CATEGORIES
 
 
 
 
 */

