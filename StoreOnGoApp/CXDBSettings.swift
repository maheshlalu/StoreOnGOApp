//
//  CXDBSettings.swift
//  Silly Monks
//
//  Created by Sarath on 28/03/16.
//  Copyright © 2016 Sarath. All rights reserved.
//

import UIKit
import CoreData

private var _SingletonSharedInstance:CXDBSettings! = CXDBSettings()

class CXDBSettings: NSObject {
    private var appDelegate:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    
    
    class var sharedInstance : CXDBSettings {
        return _SingletonSharedInstance
    }
    
    private override init() {
        
    }
    
    func destory () {
        _SingletonSharedInstance = nil
    }
    
    
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
            print("product Cat\(productCategory)")
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
        let managedContext = self.appDelegate.managedObjectContext
        let fetchRequest = NSFetchRequest(entityName: entity)
        fetchRequest.predicate = predicate
        do {
            let results =
                try managedContext.executeFetchRequest(fetchRequest)
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
                    //URL
                    if (!(attachmentUrl.valueForKey("URL") as? String)!.isEmpty) {
                        attachmentsList.addObject((attachmentUrl.valueForKey("URL") as? String)!)
                    }
                }
                //storeEntity.attachments = NSKeyedArchiver.archivedDataWithRootObject(attachmentsList)
                storeEntity.setValue(attachmentsList, forKey: "attachments")
                
                let jsonString = CXConstant.sharedInstance.convertDictionayToString(storesItem as! NSDictionary)
                storeEntity.json = jsonString as String
                do {
                    try managedContext.save()
                } catch let error as NSError  {
                    print("Could not save \(error), \(error.userInfo)")
                }
                
            }
            
        }
        
        
    }
    
    func saveProductsInDB(products:NSArray,productCategory:CX_Product_Category) {
        let managedObjContext = self.appDelegate.managedObjectContext
        let productEn = NSEntityDescription.entityForName("CX_Products", inManagedObjectContext: managedObjContext)
        for prod in products {
            let enProduct = CX_Products(entity: productEn!,insertIntoManagedObjectContext: managedObjContext)
            let createByID : String = CXConstant.sharedInstance.resultString(prod.valueForKey("createdById")!)
            enProduct.createdByID = createByID
            enProduct.mallID = createByID
            enProduct.itemCode = prod.valueForKey("ItemCode") as? String
            let jsonString = CXConstant.sharedInstance.convertDictionayToString(prod as! NSDictionary)
            enProduct.json = jsonString as String
            print("Parsing \(enProduct.json)")
            enProduct.name = prod.valueForKey("Name") as? String
            enProduct.pID = prod.valueForKey("jobTypeId") as? String
            enProduct.type = prod.valueForKey("jobTypeName") as? String
            enProduct.mallID = createByID
            do {
                try managedObjContext.save()
            } catch let error as NSError  {
                print("Could not save \(error), \(error.userInfo)")
            }
        }
        
    }
    
    
    
}
