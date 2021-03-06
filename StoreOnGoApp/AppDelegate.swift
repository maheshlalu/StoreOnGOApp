//
//  AppDelegate.swift
//  StoreOnGoApp
//
//  Created by Mahesh Y on 28/04/16.
//  Copyright © 2016 CX. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        UIApplication.sharedApplication().statusBarStyle = UIStatusBarStyle.LightContent
        
        setupCoreDate()

        checkTheBuildVersion()
        //self.checkOutCartItems()
        //Roboto-Light
        return true
    }
    
    func checkTheBuildVersion(){
         let version = NSBundle.mainBundle().objectForInfoDictionaryKey("CFBundleShortVersionString")
        print(version)
        
        if isNewVersion() {
            //Delete the old database if .txt files are modified
        //  self.removeImage("", fileExtension: "")
           print("Delete the old database if .txt files are modified")
 
       self.removeImage("SingleViewCoreData", fileExtension: "sqlite")
            self.removeImage("SingleViewCoreData", fileExtension: "sqlite-shm")
            self.removeImage("SingleViewCoreData", fileExtension: "sqlite-wal")
            setupCoreDate()

            //SingleViewCoreData.sqlite
            //SingleViewCoreData.sqlite-shm
            //SingleViewCoreData.sqlite-wal
            //1] *** Terminating app due to uncaught exception 'NSInternalInconsistencyException', reason: 'recordChangeSnapshot:forObjectID:: global ID may not be temporary when recording
            

        }else{
            
        }

    }
    
    func removeImage(itemName:String, fileExtension: String) {
        let fileManager = NSFileManager.defaultManager()
        let nsDocumentDirectory = NSSearchPathDirectory.DocumentDirectory
        let nsUserDomainMask = NSSearchPathDomainMask.UserDomainMask
        let paths = NSSearchPathForDirectoriesInDomains(nsDocumentDirectory, nsUserDomainMask, true)
        guard let dirPath = paths.first else {
            return
        }
        let filePath = "\(dirPath)/\(itemName).\(fileExtension)"
        do {
            try fileManager.removeItemAtPath(filePath)
        } catch let error as NSError {
            print(error.debugDescription)
        }
    }

      //  setupCoreDate()


    
    
    
    
    func isNewVersion()-> Bool{
        let newVersion = NSBundle.mainBundle().objectForInfoDictionaryKey("CFBundleShortVersionString") as! String

        if(NSUserDefaults.standardUserDefaults().objectForKey("VERSION") == nil)
        {
            NSUserDefaults.standardUserDefaults().setObject(newVersion, forKey: "VERSION")
            
            print("NULL")
            return true
        }else{
          let oldVersion =   NSUserDefaults.standardUserDefaults().objectForKey("VERSION") as! String
            if oldVersion == newVersion {
                return false
            }else{
                NSUserDefaults.standardUserDefaults().setObject(newVersion, forKey: "VERSION")
                return true
            }
        }

    }
    
    
    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        // Saves changes in the application's managed object context before the application terminates.
        //self.saveContext()
        //MagicalRecord.cleanUp()
    }

    // MARK: - Core Data stack

    // MARK: - Core Data stack
    func setupCoreDate() {
        NSPersistentStoreCoordinator.MR_setDefaultStoreCoordinator(persistentStoreCoordinator)
        NSManagedObjectContext.MR_initializeDefaultContextWithCoordinator(persistentStoreCoordinator)
    }
    
    
    class func shareInstance() -> AppDelegate {
        return UIApplication.sharedApplication().delegate as! AppDelegate
    }
    
    lazy var applicationDocumentsDirectory: NSURL = {
        // The directory the application uses to store the Core Data store file. This code uses a directory named "com.date.StoreOnGoApp" in the application's documents Application Support directory.
        let urls = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)
        return urls[urls.count-1]
    }()

    lazy var managedObjectModel: NSManagedObjectModel = {
        // The managed object model for the application. This property is not optional. It is a fatal error for the application not to be able to find and load its model.
        let modelURL = NSBundle.mainBundle().URLForResource("StoreOnGoData", withExtension: "momd")!
        return NSManagedObjectModel(contentsOfURL: modelURL)!
    }()

    lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator = {
        // The persistent store coordinator for the application. This implementation creates and returns a coordinator, having added the store for the application to it. This property is optional since there are legitimate error conditions that could cause the creation of the store to fail.
        // Create the coordinator and store
        let coordinator = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
        let url = self.applicationDocumentsDirectory.URLByAppendingPathComponent("SingleViewCoreData.sqlite")
        print("app directory \(url)")
        var failureReason = "There was an error creating or loading the application's saved data."
        do {
            try coordinator.addPersistentStoreWithType(NSSQLiteStoreType, configuration: nil, URL: url, options: nil)
        } catch {
            // Report any error we got.
            var dict = [String: AnyObject]()
            dict[NSLocalizedDescriptionKey] = "Failed to initialize the application's saved data"
            dict[NSLocalizedFailureReasonErrorKey] = failureReason

            dict[NSUnderlyingErrorKey] = error as NSError
            let wrappedError = NSError(domain: "YOUR_ERROR_DOMAIN", code: 9999, userInfo: dict)
            // Replace this with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog("Unresolved error \(wrappedError), \(wrappedError.userInfo)")
            abort()
        }
        
        return coordinator
    }()

    lazy var managedObjectContext: NSManagedObjectContext = {
        // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.) This property is optional since there are legitimate error conditions that could cause the creation of the context to fail.
        let coordinator = self.persistentStoreCoordinator
        var managedObjectContext = NSManagedObjectContext(concurrencyType: .MainQueueConcurrencyType)
        managedObjectContext.persistentStoreCoordinator = coordinator
        return managedObjectContext
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let dispatch = dispatch_get_main_queue()
        dispatch_async(dispatch) { () -> Void in
            NSManagedObjectContext.MR_defaultContext().MR_saveToPersistentStoreWithCompletion({ (Bool, error) -> Void in
                //TODO: do something when function finish
            })
        }
    }
    

    


}

//http://stackoverflow.com/questions/25967792/how-to-integrate-splash-screen-for-all-types-of-iphones-in-xcode-6-1
