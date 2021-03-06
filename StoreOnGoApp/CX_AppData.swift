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
      //   return
        self.configure()
        LoadingView.show("Loading", animated: true)
        CXDBSettings.sharedInstance.loadView()

        let quees1 = dispatch_queue_create(
            "com.parsedata.category", DISPATCH_QUEUE_CONCURRENT)
        dispatch_barrier_async(quees1) { // 1
            let reqUrl = CXConstant.STORES_URL + CXConstant.MallID
            SMSyncService.sharedInstance.startSyncProcessWithUrl(reqUrl) { (responseDict) -> Void in
                // print ("stores   response   data \(responseDict.valueForKey("jobs")! as! NSArray) ")
                CXDBSettings.sharedInstance.saveStoresInDB(responseDict.valueForKey("jobs")! as! NSArray)
            }
        }
        
        
        let quees2 = dispatch_queue_create(
            "com.quees2.category", DISPATCH_QUEUE_CONCURRENT)

        dispatch_barrier_async(quees2) { // 1
            self.parseTheProductSubCategory()
        }
        
        let quees3 = dispatch_queue_create(
            "com.quees3.category", DISPATCH_QUEUE_CONCURRENT)
        dispatch_barrier_async(quees3) { // 1
            self.getProductCategory()
        }
        
        let quees4 = dispatch_queue_create(
            "com.quees4.category", DISPATCH_QUEUE_CONCURRENT)
        dispatch_barrier_async(quees4) { // 1
            self.getFeaturedProducts()
        }
        
        let quees5 = dispatch_queue_create(
            "com.quees5.category", DISPATCH_QUEUE_CONCURRENT)
        dispatch_barrier_async(quees5) { // 1
            self.parseTheProductsList()
        }
 
        let quees6 = dispatch_queue_create(
            "com.quees6.category", DISPATCH_QUEUE_CONCURRENT)
        dispatch_barrier_async(quees6) { // 1
            self.miscellaneousList()
        }
        
        let quees7 = dispatch_queue_create(
            "com.quees7.category", DISPATCH_QUEUE_CONCURRENT)
        dispatch_barrier_async(quees7) { // 1
            self.parseStickersList()
        }
        

    }
    

    
    func getProductCategory(){
        let fetchRequest = NSFetchRequest(entityName: "CX_Product_Category")
        if    CX_Product_Category.MR_executeFetchRequest(fetchRequest).count == 0 {
            let reqUrl = CXConstant.PRODUCT_CATEGORY_URL + CXConstant.MallID
            SMSyncService.sharedInstance.startSyncProcessWithUrl(reqUrl) { (responseDict) -> Void in
                // print ("Product category response \(responseDict)")
                CXDBSettings.sharedInstance.saveProductCategoriesInDB(responseDict.valueForKey("jobs")! as! NSArray)
            }
        }
        
    }
    
    func getFeaturedProducts(){
        
        //CX_FeaturedProducts
        
        let fetchRequest = NSFetchRequest(entityName: "CX_FeaturedProducts")
        if    CX_FeaturedProducts.MR_executeFetchRequest(fetchRequest).count == 0 {
            let reqUrl = CXConstant.FEATUREDPRODUCT_URL + CXConstant.MallID
            SMSyncService.sharedInstance.startSyncProcessWithUrl(reqUrl) { (responseDict) -> Void in
                // print ("Featured Product  response \(responseDict)")
                CXDBSettings.sharedInstance.saveFeaturedProducts(responseDict.valueForKey("jobs")! as! NSArray)
            }
        }

    }
    
    func parseTheProductsList(){
        
        // LoadingView.show("ProductList Loading....", animated: true)
        let fetchRequest = NSFetchRequest(entityName: "CX_Products")
        fetchRequest.predicate = NSPredicate(format: "type = %@", "Products List")
        if    CX_Products.MR_executeFetchRequest(fetchRequest).count == 0 {
            let dataDic : NSDictionary = self.getTheDictionaryDataFromTextFile("productslist")
            if (dataDic.valueForKey("jobs") != nil) {
                CXDBSettings.sharedInstance.saveProductsInDB(dataDic.valueForKey("jobs")! as! NSArray, typeCategory: "Products List")
            }
        }
        
        
    }
    
    func miscellaneousList(){
        let fetchRequest = NSFetchRequest(entityName: "CX_Products")
        fetchRequest.predicate = NSPredicate(format: "type = %@", "Miscellaneous")
        if    CX_Products.MR_executeFetchRequest(fetchRequest).count == 0 {
            CXDBSettings.sharedInstance.saveProductsInDB(self.getTheDictionaryDataFromTextFile("miscellaneous").valueForKey("jobs")! as! NSArray, typeCategory: "Miscellaneous")
        }
    }
    
    func parseStickersList(){
        
        let fetchRequest = NSFetchRequest(entityName: "CX_Products")
        fetchRequest.predicate = NSPredicate(format: "type = %@", "sticker")
        if    CX_Products.MR_executeFetchRequest(fetchRequest).count == 0 {
            CXDBSettings.sharedInstance.saveProductsInDB(self.getTheDictionaryDataFromTextFile("sticker").valueForKey("jobs")! as! NSArray, typeCategory: "sticker")
        }
        
    }
    
    func parseTheProductSubCategory(){
        //LoadingView.show("Subcategory Loading....", animated: true)
        let fetchRequest = NSFetchRequest(entityName: "TABLE_PRODUCT_SUB_CATEGORIES")
        if    TABLE_PRODUCT_SUB_CATEGORIES.MR_executeFetchRequest(fetchRequest).count == 0 {
           // dispatch_async(dispatch_get_global_queue(QOS_CLASS_BACKGROUND, 0), {
                //call your background operation.
                let dataDic : NSDictionary = self.getTheDictionaryDataFromTextFile("subcate")
                if (dataDic.valueForKey("jobs") != nil) {
                    CXDBSettings.sharedInstance.savetheSubCategoryData(dataDic.valueForKey("jobs")! as! NSArray)
                }
           // })
        }

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
        config.size = 100
        config.backgroundColor = UIColor.blackColor() //UIColor(red:0.03, green:0.82, blue:0.7, alpha:1)
        config.spinnerColor =  UIColor.whiteColor()//UIColor(red:0.88, green:0.26, blue:0.18, alpha:1)
        config.titleTextColor =  UIColor.whiteColor()//UIColor(red:0.88, green:0.26, blue:0.18, alpha:1)
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

