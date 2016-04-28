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
    
    
  /*  func saveProductCategoriesInDB(productCategories:NSArray,catID:String) {
        let predicate:NSPredicate = NSPredicate(format: "createdById = %@", catID)
        if self.getRequiredItemsFromDB("CX_Product_Category", predicate: predicate).count == 0 {
            let managedContext = self.appDelegate.managedObjectContext
            let productCatEn = NSEntityDescription.entityForName("CX_Product_Category", inManagedObjectContext: managedContext)
            for productCategory in productCategories {
                let enProCat = CX_Product_Category(entity: productCatEn!,insertIntoManagedObjectContext: managedContext)
                let createByID : String = CXConstant.sharedInstance.resultString(productCategory.valueForKey("createdById")!)
                enProCat.pid = productCategory.valueForKey("id") as? String
                enProCat.categoryMall = productCategory.valueForKey("Category_Mall") as? String
                enProCat.itemCode = productCategory.valueForKey("ItemCode") as? String
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
    }*/
    
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
}
