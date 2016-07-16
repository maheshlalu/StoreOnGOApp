//
//  CXDBSettings.swift
//  Silly Monks
//
//  Created by Sarath on 28/03/16.
//  Copyright © 2016 Sarath. All rights reserved.
//

import UIKit
import CoreData
protocol AppDataDelegate {
    func completedTheFetchingTheData(sender: CXDBSettings)
    
}

private var _SingletonSharedInstance:CXDBSettings! = CXDBSettings()

class CXDBSettings: NSObject {
    private var appDelegate:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    
     var dataDelegate:AppDataDelegate?

    class var sharedInstance : CXDBSettings {
        return _SingletonSharedInstance
    }
    
    private override init() {
        
    }
    
    func destory () {
        _SingletonSharedInstance = nil
    }
    
    /*
     @NSManaged var addToCart: String?
     @NSManaged var itemCode: String?
     @NSManaged var name: String?
     @NSManaged var pID: String?
     @NSManaged var quantity: String?
     @NSManaged var storeID: String?
     @NSManaged var subCatNameID: String?
     @NSManaged var type: String?
     */
    
    func isAddToCart(productID : NSString) -> (isAdded:Bool, totalCount:NSString) {
        let fetchRequest = NSFetchRequest(entityName: "CX_Cart")
        fetchRequest.predicate = NSPredicate(format: "pID = %@", productID)
        let cartsDataArrya : NSArray = CX_Cart.MR_executeFetchRequest(fetchRequest)
        if cartsDataArrya.count != 0 {
            let  cart = cartsDataArrya.lastObject as?CX_Cart
            return (true,(cart?.quantity)!)
        }else{
            return (false,"")
        }
    }
    
    func deleteCartItem(productId : NSString){
        let predicate:NSPredicate = NSPredicate(format: "pID = %@",productId)
        let fetchRequest = NSFetchRequest(entityName: "CX_Cart")
        fetchRequest.predicate = predicate
        let cartsDataArrya : NSArray = CX_Cart.MR_executeFetchRequest(fetchRequest)
        NSManagedObjectContext.MR_contextForCurrentThread().deleteObject((cartsDataArrya.lastObject as?CX_Cart)!)
         NSManagedObjectContext.MR_contextForCurrentThread().MR_saveOnlySelfAndWait()
        NSNotificationCenter.defaultCenter().postNotificationName("updateCartBtnAction", object: nil)

        
    }
    
    func addToCart(product:CX_Products,quantityNumber : NSString){
        
        MagicalRecord.saveWithBlock({ (localContext : NSManagedObjectContext!) in
            
            let productEn = NSEntityDescription.entityForName("CX_Cart", inManagedObjectContext: localContext)
            
            let predicate:NSPredicate = NSPredicate(format: "pID = %@", product.pID!)
            let fetchRequest = NSFetchRequest(entityName: "CX_Cart")
            fetchRequest.predicate = predicate
            if CX_Cart.MR_executeFetchRequest(fetchRequest).count == 0 {
                let enProduct = CX_Cart(entity: productEn!,insertIntoManagedObjectContext: localContext)
                product.addToCart = "YES"
                enProduct.itemCode = product.itemCode
                enProduct.name =  product.name
                enProduct.pID = product.pID
                enProduct.quantity = quantityNumber as String
                enProduct.storeID = product.storeID
                enProduct.subCatNameID = product.subCatNameID
                enProduct.type = product.name
            }
            
            
            }, completion: { (success : Bool, error : NSError!) in
                
                print("save the data >>>>>")
                
                NSNotificationCenter.defaultCenter().postNotificationName("updateCartBtnAction", object: nil)

                //LoadingView.hide()
                // This block runs in main thread
        })
        
        
        
        
    }
    
    
    func addToCartToItem (itemCode : NSString, isAddToItem : Bool ,quantityNumber : NSString){
        
        let managedContext = self.appDelegate.managedObjectContext

        let productEn = NSEntityDescription.entityForName("CX_Products", inManagedObjectContext: NSManagedObjectContext.MR_contextForCurrentThread())
        let fetchRequest = CX_Products.MR_requestAllSortedBy("name", ascending: true)
        var predicate:NSPredicate = NSPredicate()
        predicate = NSPredicate(format: "itemCode = %@ ", itemCode)
        fetchRequest.predicate = predicate
        fetchRequest.entity = productEn
        let productData :  NSArray  =   CX_Products.MR_executeFetchRequest(fetchRequest)
        if productData.count != 0 {
            let product : CX_Products = productData.firstObject as! CX_Products
            if isAddToItem {
                product.quantity = quantityNumber as String
                product.addToCart = "YES"
            }else{
                
            }
        }
        do {
            try managedContext.save()
        } catch let error as NSError  {
            print("Could not save \(error), \(error.userInfo)")
        }
        

        
    }
    //select * from ZCX_PRODUCTS where ZITEMCODE = 'NAJ0459'
    
    
    func saveProductCategoriesInDB(productCategories:NSArray) {
        
        for productCategory in productCategories {
            let itemID = CXConstant.sharedInstance.resultString(productCategory.valueForKey("id")!)
            let predicate:NSPredicate = NSPredicate(format: "pid = %@", itemID)
            let managedContext = self.appDelegate.managedObjectContext
            let productCatEn = NSEntityDescription.entityForName("CX_Product_Category", inManagedObjectContext: managedContext)
            
            if self.getRequiredItemsFromDB("CX_Product_Category", predicate: predicate).count == 0 {
                let enProCat = CX_Product_Category(entity: productCatEn!,insertIntoManagedObjectContext: managedContext)
                let createByID : String = CXConstant.sharedInstance.resultString(productCategory.valueForKey("createdById")!)
                enProCat.pid = CXConstant.sharedInstance.resultString(productCategory.valueForKey("id")!)
                enProCat.categoryMall = productCategory.valueForKey("Category_Mall") as? String
                enProCat.itemCode = CXConstant.sharedInstance.resultString(productCategory.valueForKey("ItemCode")!)
                enProCat.createdByFullName = productCategory.valueForKey("createdByFullName") as? String
                enProCat.createdById = createByID
                enProCat.mallID = createByID
                enProCat.publicUrl = productCategory.valueForKey("publicURL") as? String
                enProCat.name = productCategory.valueForKey("Name") as? String
                enProCat.productDescription = productCategory.valueForKey("Description") as? String
                enProCat.storeID = productCategory.valueForKey("storeId") as? String
                enProCat.currentJobStatus = productCategory.valueForKey("Current_Job_Status") as? String
                enProCat.packageName = productCategory.valueForKey("PackageName") as? String
                enProCat.createdOn = productCategory.valueForKey("createdOn") as? String
                enProCat.jobTypeID = productCategory.valueForKey("jobTypeId") as? String
                enProCat.jobTypeName = productCategory.valueForKey("jobTypeName") as? String
                enProCat.overallRating = productCategory.valueForKey("overallRating") as? String
                enProCat.totalReviews = productCategory.valueForKey("totalReviews") as? String
                do {
                    try managedContext.save()
                } catch let error as NSError  {
                    print("Could not save \(error), \(error.userInfo)")
                }
            }
            //print("product Cat\(productCategory)")
        }
    }
    
    /*
     9618665901
     func getAllMallsInDB() -> NSArray{
     let managedContext = self.appDelegate.managedObjectContext
     let fetchRequest = NSFetchRequest(entityName: "CX_AllMalls")
     do {
     let results =
     try managedContext.executeFetchRequest(fetchRequest)
     return results as! [NSManagedObject]
     } catch let error as NSError {
     print("Could not fetch \(error), \(error.userInfo)")
     }
     return NSArray()
     }
     
     */
    
    //    func getAllProductCategories(predicate:NSPredicate) -> NSArray {
    //        let managedContext = self.appDelegate.managedObjectContext
    //        let fetchRequest = NSFetchRequest(entityName: "CX_Product_Category")
    //        fetchRequest.predicate = predicate
    //        do {
    //            let results =
    //                try managedContext.executeFetchRequest(fetchRequest)
    //            return results as! [NSManagedObject]
    //        } catch let error as NSError {
    //            print("Could not fetch \(error), \(error.userInfo)")
    //        }
    //        return NSArray()
    //    }
    
    func getRequiredItemsFromDB(entity:String,predicate:NSPredicate) -> NSArray {
        
        let moc = self.appDelegate.managedObjectContext
        let privateMOC = NSManagedObjectContext(concurrencyType: .PrivateQueueConcurrencyType)
        privateMOC.parentContext = moc
        
        let fetchRequest = NSFetchRequest(entityName: entity)
        fetchRequest.predicate = predicate
        do {
            let results =
                try privateMOC.executeFetchRequest(fetchRequest)
            return results as! [NSManagedObject]
        } catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
        }
        
        return NSArray()
    }
    //MARK: Get Stores
    
    func getTableData(entity:String) ->NSArray{
        let managedContext = self.appDelegate.managedObjectContext
        let fetchRequest = NSFetchRequest(entityName: entity)
        do {
            let results =
                try managedContext.executeFetchRequest(fetchRequest)
            return results as! [NSManagedObject]
        } catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
        }
        
        return NSArray()
    }
    
    func saveStoresInDB(stores:NSArray) {
        
        //let predicate:NSPredicate = NSPredicate(format: "createdById = %@", catID)
        
        let managedContext = self.appDelegate.managedObjectContext
        let productCatEn = NSEntityDescription.entityForName("CX_Stores", inManagedObjectContext: managedContext)
        print ("stores   response   data \(stores) ")
        for storesItem in stores {
            
            let itemID = CXConstant.sharedInstance.resultString(storesItem.valueForKey("id")!)
            let predicate:NSPredicate = NSPredicate(format: "id = %@", itemID)
            if self.getRequiredItemsFromDB("CX_Stores", predicate: predicate).count == 0 {
                
                let storeEntity = CX_Stores(entity: productCatEn!,insertIntoManagedObjectContext: managedContext)
                storeEntity.id = CXConstant.sharedInstance.resultString(storesItem.valueForKey("id")!)
                storeEntity.createdById = CXConstant.sharedInstance.resultString(storesItem.valueForKey("createdById")!)
                storeEntity.jobTypeId = CXConstant.sharedInstance.resultString(storesItem.valueForKey("jobTypeId")!)
                storeEntity.jobTypeName = storesItem.valueForKey("jobTypeName") as? String
                storeEntity.name = storesItem.valueForKey("Name") as? String
                storeEntity.address = storesItem.valueForKey("Address") as? String
                storeEntity.descriptionData = storesItem.valueForKey("Description") as? String
                storeEntity.longitude = storesItem.valueForKey("Longitude") as? String
                storeEntity.latitude = storesItem.valueForKey("Latitude") as? String
                storeEntity.city = storesItem.valueForKey("City") as? String
                storeEntity.contactNumber = storesItem.valueForKey("Contact Number") as? String
                storeEntity.faceBook = storesItem.valueForKey("FaceBook") as? String
                storeEntity.twitter = storesItem.valueForKey("Twitter") as? String
                
                let attachmentsList = NSMutableArray()
                for attachmentUrl in (storesItem.valueForKey("Attachments") as? NSArray)! {
                    if (!(attachmentUrl.valueForKey("URL") as? String)!.isEmpty && (attachmentUrl.valueForKey("isBannerImage") as? String) == "true") {
                        attachmentsList.addObject((attachmentUrl.valueForKey("URL") as? String)!)
                    }
                }
                storeEntity.setValue(attachmentsList, forKey: "attachments")
                let jsonString = CXConstant.sharedInstance.convertDictionayToString(storesItem as! NSDictionary)
                storeEntity.json = jsonString as String
                do {
                    
                    try managedContext.save()
                    
                    dispatch_async(dispatch_get_main_queue(), {
                        self.dataDelegate?.completedTheFetchingTheData(self)
                    })

                } catch let error as NSError  {
                    print("Could not save \(error), \(error.userInfo)")
                }
                
            }else{
                dispatch_async(dispatch_get_main_queue(), {
                    self.dataDelegate?.completedTheFetchingTheData(self)
                })
            }
            
        }
        
        
    }
    
    func saveProductsInDB(products:NSArray,typeCategory:NSString) {
        
         MagicalRecord.saveWithBlock({ (localContext : NSManagedObjectContext!) in
            
            let productEn = NSEntityDescription.entityForName("CX_Products", inManagedObjectContext: localContext)

            for prod in products {
                
                let itemID = CXConstant.sharedInstance.resultString(prod.valueForKey("id")!)
                let predicate:NSPredicate = NSPredicate(format: "pID = %@", itemID)
                let fetchRequest = NSFetchRequest(entityName: "CX_Products")
                fetchRequest.predicate = predicate
                
                if CX_Products.MR_executeFetchRequest(fetchRequest).count == 0 {
                    
                    let enProduct = CX_Products(entity: productEn!,insertIntoManagedObjectContext: localContext)

                    let createByID : String = CXConstant.sharedInstance.resultString(prod.valueForKey("createdById")!)
                    enProduct.createdByID = createByID
                    enProduct.mallID = createByID
                    enProduct.itemCode = prod.valueForKey("ItemCode") as? String
                    let jsonString = CXConstant.sharedInstance.convertDictionayToString(prod as! NSDictionary)
                    enProduct.json = jsonString as String
                    //print("Parsing \(enProduct.json)")
                    enProduct.name = prod.valueForKey("Name") as? String
                    enProduct.pID = CXConstant.sharedInstance.resultString(prod.valueForKey("id")!)
                    // enProduct.type = prod.valueForKey("jobTypeName") as? String
                    enProduct.type = typeCategory as String
                    enProduct.mallID = createByID
                    enProduct.subCatNameID = prod.valueForKey("SubCategoryType") as? String
                    enProduct.p3rdCategory =  prod.valueForKey("P3rdCategory") as? String
                    
                }
            }
            
            }, completion: { (success : Bool, error : NSError!) in
                
                print("save the data >>>>>")
                LoadingView.hide()
                dispatch_async(dispatch_get_main_queue(), {
                    self.dataDelegate?.completedTheFetchingTheData(self)
                })
                
                // This block runs in main thread
        })
        
    }
    
    //MARK : Featured products
    
    func saveFeaturedProducts(products:NSArray){
        //print("featured products \(products)")
        let managedObjContext = self.appDelegate.managedObjectContext
        let featureProductEn = NSEntityDescription.entityForName("CX_FeaturedProducts", inManagedObjectContext: managedObjContext)
        for prod in products {
            let itemID = CXConstant.sharedInstance.resultString(prod.valueForKey("id")!)
            let predicate:NSPredicate = NSPredicate(format: "id = %@", itemID)
            if self.getRequiredItemsFromDB("CX_FeaturedProducts", predicate: predicate).count == 0 {
                let enProduct = CX_FeaturedProducts(entity: featureProductEn!,insertIntoManagedObjectContext: managedObjContext)
                enProduct.id = CXConstant.sharedInstance.resultString(prod.valueForKey("id")!)
                enProduct.itemCode = CXConstant.sharedInstance.resultString(prod.valueForKey("ItemCode")!)
                enProduct.jobTypeId = CXConstant.sharedInstance.resultString(prod.valueForKey("jobTypeId")!)
                enProduct.jobTypeName = prod.valueForKey("jobTypeName") as? String
                enProduct.createdByFullName = prod.valueForKey("createdByFullName") as? String
                enProduct.name = prod.valueForKey("Name") as? String
                enProduct.publicURL = prod.valueForKey("publicURL") as? String
                enProduct.campaign_Jobs = prod.valueForKey("Campaign_Jobs") as? String
                do {
                    try managedObjContext.save()
                } catch let error as NSError  {
                    print("Could not save \(error), \(error.userInfo)")
                }
                
            }
        }
        
    }
    
    func savetheSubCategoryData(subCategory:NSArray){
        
        MagicalRecord.saveWithBlock({ (localContext : NSManagedObjectContext!) in
            
              let subCategoryEntity = NSEntityDescription.entityForName("TABLE_PRODUCT_SUB_CATEGORIES", inManagedObjectContext: localContext)
            
            for prod in subCategory {
                let itemID = CXConstant.sharedInstance.resultString(prod.valueForKey("id")!)
                let predicate:NSPredicate = NSPredicate(format: "id = %@", itemID)
                let fetchRequest = NSFetchRequest(entityName: "TABLE_PRODUCT_SUB_CATEGORIES")
                fetchRequest.predicate = predicate
                
                if TABLE_PRODUCT_SUB_CATEGORIES.MR_executeFetchRequest(fetchRequest).count == 0 {
                    
                    let enProduct = TABLE_PRODUCT_SUB_CATEGORIES(entity: subCategoryEntity!,insertIntoManagedObjectContext: localContext)

                    enProduct.id = CXConstant.sharedInstance.resultString(prod.valueForKey("id")!)
                    enProduct.itemCode = CXConstant.sharedInstance.resultString(prod.valueForKey("ItemCode")!)
                    enProduct.createdByFullName = prod.valueForKey("createdByFullName") as? String
                    enProduct.name = prod.valueForKey("Name") as? String
                    enProduct.createdById = CXConstant.sharedInstance.resultString(prod.valueForKey("createdById")!)
                    enProduct.descriptionData = prod.valueForKey("Description") as? String
                    enProduct.masterCategory = prod.valueForKey("MasterCategory") as? String
                    enProduct.icon_URL =  prod.valueForKey("Image_URL") as? String
                    
                }
            }
            // This block runs in background thread
            }, completion: { (success : Bool, error : NSError!) in
                print("save the data >>>>>")
                LoadingView.hide()
                // This block runs in main thread
        })
        
    }
    

    
   /* func actionShowLoader() {
        
        var config : SwiftLoader.Config = SwiftLoader.Config()
        config.size = 170
        config.backgroundColor = UIColor(red:0.03, green:0.82, blue:0.7, alpha:1)
        config.spinnerColor = UIColor(red:0.88, green:0.26, blue:0.18, alpha:1)
        config.titleTextColor = UIColor(red:0.88, green:0.26, blue:0.18, alpha:1)
        config.spinnerLineWidth = 2.0
        config.foregroundColor = UIColor.blackColor()
        config.foregroundAlpha = 0.5
        
        
        SwiftLoader.setConfig(config)
        
        //SwiftLoader.show(animated: true)
//        
//        delay(seconds: 3.0) { () -> () in
//            SwiftLoader.show("Loading...", animated: true)
//        }
//        delay(seconds: 6.0) { () -> () in
//            SwiftLoader.hide()
//        }
        
    }
    
    func delay(seconds seconds: Double, completion:()->()) {
        let popTime = dispatch_time(DISPATCH_TIME_NOW, Int64( Double(NSEC_PER_SEC) * seconds ))
        
        dispatch_after(popTime, dispatch_get_main_queue()) {
            completion()
        }
    }*/

}
