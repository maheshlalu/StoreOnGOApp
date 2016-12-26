//
//  AboutUsViewCnt.swift
//  StoreOnGoApp
//
//  Created by Rama kuppa on 08/05/16.
//  Copyright © 2016 CX. All rights reserved.
//

import UIKit
import MessageUI

class AboutUsViewCnt: UIViewController,MFMessageComposeViewControllerDelegate {
    
    var coverPageImagesList: NSMutableArray!
    var aboutUsDict:NSDictionary!
    var heder: UIView!
    var presentWindow : UIWindow?
    var descText:String!
   
    @IBOutlet weak var imagePager: KIImagePager!
    @IBOutlet weak var aboutUsTableview: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBarHidden = true
        self.designHeaderView()
       // self.setupPagenator()
        self.getStores()
        self.getAboutDict()
        

        self.aboutUsTableview.estimatedRowHeight = 96
        self.aboutUsTableview.rowHeight = UITableViewAutomaticDimension
        
        let aboutNib = UINib(nibName: "AboutUsTableViewCell", bundle: nil)
        self.aboutUsTableview.registerNib(aboutNib, forCellReuseIdentifier: "AboutUsTableViewCell")
        
        let aboutCallNib = UINib(nibName: "CallTableViewCell", bundle: nil)
        self.aboutUsTableview.registerNib(aboutCallNib, forCellReuseIdentifier: "CallTableViewCell")
        
        let aboutDetail = UINib(nibName: "aboutUsDetailTableViewCell", bundle: nil)
        self.aboutUsTableview.registerNib(aboutDetail, forCellReuseIdentifier: "aboutUsDetailTableViewCell")
        
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBarHidden = true
        self.designHeaderView()
    }
    
    // Designing Navigation Bar
    func designHeaderView (){
        
        if NSUserDefaults.standardUserDefaults().valueForKey("USER_ID") != nil{
            heder =  CXHeaderView.init(frame: CGRectMake(0, 0, CXConstant.screenSize.width, CXConstant.headerViewHeigh), andTitle: "About Us", andDelegate: self, backButtonVisible: true, cartBtnVisible: true,profileBtnVisible: true, isForgot: false ,isLogout:true)
        }else{
            heder = CXHeaderView.init(frame: CGRectMake(0, 0, CXConstant.screenSize.width, CXConstant.headerViewHeigh), andTitle: "About Us", andDelegate: self, backButtonVisible: true, cartBtnVisible: true,profileBtnVisible: true, isForgot: false,isLogout:false)
        }
        self.view.addSubview(heder)
        
    }
    // MARK: - SetUp Paginater
    
    func setupPagenator (){
        
        //self.imagePager = KIImagePager()
        imagePager.pageControl.currentPageIndicatorTintColor = UIColor.lightGrayColor()
        imagePager.pageControl.pageIndicatorTintColor = UIColor.blackColor()
        imagePager.slideshowTimeInterval = 2
        imagePager.slideshowShouldCallScrollToDelegate = true
        imagePager.checkWetherToToggleSlideshowTimer()
        imagePager.backgroundColor = UIColor.redColor()
        self.view.addSubview(imagePager)
    }
    
    //MARK: Get Stores
    func getStores(){
        if CXDBSettings.sharedInstance.getTableData("CX_Stores").count != 0 {
            let storesData : CX_Stores = CXDBSettings.sharedInstance.getTableData("CX_Stores").lastObject as! CX_Stores
            self.coverPageImagesList = storesData.attachments as? NSMutableArray
            self.aboutUsDict = CXConstant.sharedInstance.convertStringToDictionary(storesData.json!)
            print(aboutUsDict)
        }
    }
    
    func alertWithMessage(alertMessage:String){
        
        let alert = UIAlertController(title: "NV Agencies", message:alertMessage, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "Okay", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
        
    }
    
    func callBtnAction(){

        let mobileNum = self.aboutUsDict.valueForKey("Contact Number") as! String
        UIApplication.sharedApplication().openURL(NSURL(string: "tel://\(mobileNum)")!)

    }
    
    func smsAction(){
    
        if (MFMessageComposeViewController.canSendText()) {
            
            let mobileNum = self.aboutUsDict.valueForKey("Contact Number") as! String
            let messageVC = MFMessageComposeViewController()
            messageVC.body = "Hi Do you have any query?"
            messageVC.recipients = [mobileNum]
            messageVC.messageComposeDelegate = self
            self.presentViewController(messageVC, animated: true, completion: nil)
            
        } else {
            
            // Let the user know if his/her device isn't able to send text messages
//            let errorAlert = UIAlertView(title: "Cannot Send Text Message", message: "Your device is not able to send text messages.", delegate: self, cancelButtonTitle: "OK")
//            errorAlert.show()
            
        }
    }
    
    func messageComposeViewController(controller: MFMessageComposeViewController, didFinishWithResult result: MessageComposeResult) {
        controller.dismissViewControllerAnimated(true, completion: nil)
    }

    
    func mapAction() {
        
        let destinationLatitude = Double(self.aboutUsDict.valueForKey("Latitude")! as! String)
        let destinationLongtitude = Double(self.aboutUsDict.valueForKey("Longitude")! as! String)
        let googleMapUrlString = String.localizedStringWithFormat("http://maps.google.com/?daddr=%f,%f", destinationLatitude!, destinationLongtitude!)
        UIApplication.sharedApplication().openURL(NSURL(string: googleMapUrlString)!)
    }
    
    
    func getAboutDict(){
        
        let signUpUrl = "http://storeongo.com:8081/Services/getMasters?type=About%20Us"+"&mallId="+CXConstant.MallID
        SMSyncService.sharedInstance.startSyncProcessWithUrl(signUpUrl) { (responseDict) in
            let arr = responseDict.valueForKey("jobs") as! NSArray
            let str = arr.lastObject as! NSDictionary
            let descriptionTxt = "<span style=\"font-family: Roboto-Regular; font-size: 10\">\(str.valueForKey("Description") as! String)</span>"
            self.descText = descriptionTxt
        }
    }
    
}

extension AboutUsViewCnt:UITableViewDelegate, UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        if indexPath.section == 0{
            
            let cell = aboutUsTableview.dequeueReusableCellWithIdentifier("AboutUsTableViewCell", forIndexPath: indexPath) as! AboutUsTableViewCell
            cell.setSelected(false, animated: true)
            
            cell.templateImg.image = UIImage(named: "home")
            cell.titleLbl.text = "NV Agencies"
            cell.descriptionLbl?.text = self.aboutUsDict.valueForKey("Description") as? String
            
             return cell
        
        }else if indexPath.section == 1{
            
            let cell = aboutUsTableview.dequeueReusableCellWithIdentifier("AboutUsTableViewCell", forIndexPath: indexPath) as! AboutUsTableViewCell
            cell.setSelected(false, animated: true)
            
            cell.templateImg.image = UIImage(named: "address")
            cell.titleLbl.text = "Address"
            cell.descriptionLbl?.text = self.aboutUsDict.valueForKey("Address") as? String
            
             return cell
        }else if indexPath.section == 2{
            
            let cell = aboutUsTableview.dequeueReusableCellWithIdentifier("CallTableViewCell", forIndexPath: indexPath) as! CallTableViewCell
            cell.setSelected(false, animated: true)

            cell.callBtn.addTarget(self, action: #selector(callBtnAction), forControlEvents: UIControlEvents.TouchUpInside)
            cell.smsBtn.addTarget(self, action: #selector(smsAction), forControlEvents: UIControlEvents.TouchUpInside)
            cell.mapBtn.addTarget(self, action: #selector(mapAction), forControlEvents: UIControlEvents.TouchUpInside)
            
            return cell
            
        }else if indexPath.section == 3{
            
            let cell = aboutUsTableview.dequeueReusableCellWithIdentifier("aboutUsDetailTableViewCell", forIndexPath: indexPath) as! aboutUsDetailTableViewCell
            cell.setSelected(false, animated: true)
            
            cell.descriptionWebView.loadHTMLString(self.descText, baseURL: nil)
            
            return cell
        }
        
        return UITableViewCell()
    }

    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 5
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 5
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.section == 2{
            return 84
        }else if indexPath .section == 3{
            return 170
        }else{
            return UITableViewAutomaticDimension
        }
    }
}

extension AboutUsViewCnt:KIImagePagerDelegate,KIImagePagerDataSource {
    
    func contentModeForImage(image: UInt, inPager pager: KIImagePager!) -> UIViewContentMode {
        
        return .ScaleToFill
    }
    
    func arrayWithImages(pager: KIImagePager!) -> [AnyObject]! {
        return self.coverPageImagesList as [AnyObject]
    }
    
}

extension AboutUsViewCnt : HeaderViewDelegate {
    
    func backButtonAction (){
        self.navigationController?.popViewControllerAnimated(true)
    }
    func presentViewController(popUpView: CAPopUpViewController!) {
        self.presentViewController(popUpView, animated: true) {
        }
    }
    func cartButtonAction(){
        let cartView : CartViewCntl = CartViewCntl.init()
        self.navigationController?.pushViewController(cartView, animated: false)
    }
    func navigationProfileandLogout(isProfile: Bool) {
        let profile : CXSignInSignUpViewController = CXSignInSignUpViewController.init()
        self.navigationController?.pushViewController(profile, animated: false)
    }
    
    func navigateToProfilepage() {
        if NSUserDefaults.standardUserDefaults().valueForKey("USER_ID") == nil{
            let profile : CXSignInSignUpViewController = CXSignInSignUpViewController.init()
            self.navigationController?.pushViewController(profile, animated: false)
        }else{
            presentWindow?.makeToast(message: "Coming Soon!!")
        }
    }
    func userLogout() {
        designHeaderView()
        alertWithMessage("User Logout Successfully!")
        
    }
    
}

