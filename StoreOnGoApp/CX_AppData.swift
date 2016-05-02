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

    }
    
    
    
}


/*{
 averageRating = 0;
 count = 1;
 guestUserEmail = "guest@storeongo.com";
 guestUserId = 16;
 jobs =     (
 {
 "Additional_Details" =             {
 };
 Attachments =             (
 );
 "Campaign_Images" =             (
 "https://s3-ap-southeast-1.amazonaws.com/storeongocontent/jobs/jobFldAttachments/4452_1454909191866.jpg",
 "https://s3-ap-southeast-1.amazonaws.com/storeongocontent/JOB_FLD_ATTACHMENT/uploaded/files/706814_1454909499038.jpg",
 "https://s3-ap-southeast-1.amazonaws.com/storeongocontent/JOB_FLD_ATTACHMENT/uploaded/files/704962_1454670547742.jpg",
 "http://s3-ap-southeast-1.amazonaws.com/storeongocontent/JOB_FLD_ATTACHMENT/uploaded/files/704756_1454665591391.jpg",
 "http://s3-ap-southeast-1.amazonaws.com/storeongocontent/JOB_FLD_ATTACHMENT/uploaded/files/704702_1454665017529.jpg"
 );
 "Campaign_Jobs" = "111087_110927_110897_110866_110862";
 "Category_Mall" = "Motor Accessories";
 CreatedSubJobs =             (
 );
 "Current_Job_Status" = Active;
 "Current_Job_StatusId" = 132774;
 Description = "";
 Insights =             (
 {
 Pinterest = 0;
 points = "0.0";
 },
 {
 Twitter = 0;
 points = "0.0";
 },
 {
 Hangouts = 0;
 points = "0.0";
 },
 {
 Instagram = 0;
 points = "0.0";
 },
 {
 Messaging = 0;
 points = "0.0";
 },
 {
 Linkedin = 0;
 points = "0.0";
 },
 {
 "Google+" = 0;
 points = "0.0";
 },
 {
 Facebook = 0;
 points = "0.0";
 },
 {
 Gmail = 0;
 points = "0.0";
 },
 {
 Skype = 0;
 points = "0.0";
 },
 {
 "Campaigns Comment" = 0;
 points = "0.0";
 },
 {
 WhatsApp = 0;
 points = "0.0";
 },
 {
 "Campaigns Share" = 0;
 points = "0.0";
 },
 {
 "Campaigns Favorite" = 0;
 points = "0.0";
 },
 {
 "Campaigns View" = 0;
 points = "0.0";
 },
 {
 "Services Comment" = 0;
 points = "0.0";
 },
 {
 "Services Share" = 0;
 points = "0.0";
 },
 {
 "Services Favorite" = 0;
 points = "0.0";
 },
 {
 "Services View" = 0;
 points = "0.0";
 },
 {
 "Offers Comment" = 0;
 points = "0.0";
 },
 {
 "Offers Favorite" = 0;
 points = "0.0";
 },
 {
 "Offers Share" = 0;
 points = "0.0";
 },
 {
 "Offers View" = 0;
 points = "0.0";
 },
 {
 "Products Comment" = 0;
 points = "0.0";
 },
 {
 "Products Buy" = 0;
 points = "0.0";
 },
 {
 "Products Cart" = 0;
 points = "0.0";
 },
 {
 "Products Share" = 0;
 points = "0.0";
 },
 {
 "Products Favorite" = 0;
 points = "0.0";
 },
 {
 "Products View" = 0;
 points = "0.0";
 },
 {
 Login = 0;
 points = "0.0";
 },
 {
 Register = 0;
 points = "0.0";
 }
 );
 ItemCode = "CM_1454909946010";
 Name = "Latest_Products";
 "Next_Job_Statuses" =             (
 {
 SeqNo = 2;
 "Status_Id" = 132775;
 "Status_Name" = Inactive;
 "Sub_Jobtype_Forms" =                     (
 );
 }
 );
 "Next_Seq_Nos" = 2;
 PackageName = "";
 createdByFullName = "NV Agencies";
 createdById = 4452;
 createdOn = "05:39 Feb 8, 2016";
 guestUserEmail = "guest@storeongo.com";
 guestUserId = 16;
 hrsOfOperation =             (
 );
 id = 111090;
 jobComments =             (
 );
 jobTypeId = 56971;
 jobTypeName = "Featured Products";
 lastModifiedDate = "08-2-2016 05:39:06:00";
 overallRating = "0.0";
 publicURL = "http://storeongo.com/app/4452/Notifications;Featured Products;111090;_;SingleProduct";
 totalReviews = 0;
 }
 );
 showFields = 0;
 showInsights = 0;
 showJTJobs = 0;
 showStatuses = 0;
 status = 1;
 totalNumRecords = 1;
 userdetails =     {
 email = "nv_agencies_sog@yahoo.co.in";
 fullname = "NV Agencies";
 id = 4452;
 subdomain = "ongo_4452";
 website = "http://www.nvagencies.org/";
 };
 }
*/
