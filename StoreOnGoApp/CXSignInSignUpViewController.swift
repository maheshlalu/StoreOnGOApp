//
//  CXSignInSignUpViewController.swift
//  Silly Monks
//
//  Created by Sarath on 07/04/16.
//  Copyright © 2016 Sarath. All rights reserved.
//

import UIKit
import Foundation


protocol CXSingInDelegate {
    func didGoogleSignIn()
}

class CXSignInSignUpViewController: UIViewController,UITextFieldDelegate {
    var emailAddressField: UITextField!
    var passwordField: UITextField!
    var signInBtn:UIButton!
    var signUpBtn:UIButton!
    var backButton:UIButton!
    
    var cScrollView:UIScrollView!
    var keyboardIsShown:Bool!
    
    //var orgID:String! = CXConstant.MALL_ID
    var profileImageStr:String!
    var profileImagePic:UIImageView!
    var delegate:CXSingInDelegate?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.grayColor();
        self.keyboardIsShown = false
        self.designHeaderView()
        self.customizeMainView()
        
    }
    
    
    func setTheNavigationProperty(){
        super.viewDidLoad()
        self.title = "WELOCOME TO NV AGENCIES"
        //self.designHeaderView()
        self.navigationController?.navigationBarHidden = false
        navigationController!.navigationBar.tintColor = UIColor.whiteColor()
        navigationController!.navigationBar.barTintColor = UIColor.grayColor()
        navigationController!.navigationBar.titleTextAttributes =
            [NSForegroundColorAttributeName: UIColor.whiteColor()]
        self.navigationController!.navigationBar.titleTextAttributes = [ NSFontAttributeName: UIFont(name: "Roboto-Regular", size: 15)!]
        self.navigationController!.navigationBar.frame = CGRectMake(0, 0, CXConstant.screenSize.width, CXConstant.headerViewHeigh)
        
    }
    
    
    func designHeaderView (){
        
        let heder: UIView =  CXHeaderView.init(frame: CGRectMake(0, 0, CXConstant.screenSize.width, CXConstant.headerViewHeigh), andTitle: "Sign in or Sign up", andDelegate: self, backButtonVisible: true, cartBtnVisible: true)
        
        self.view.addSubview(heder)
        
    }
    
//    func customizeHeaderView() {
//        self.navigationController?.navigationBar.translucent = false;
//        self.navigationController?.navigationBar.barTintColor = UIColor.navBarColor()
//        
//        let lImage = UIImage(named: "left_aarow.png") as UIImage?
//        //self.backButton.hidden = false
//        self.backButton = UIButton (type: UIButtonType.Custom) as UIButton
//        self.backButton.frame = CGRectMake(0, 0, 40, 40)
//        self.backButton.setImage(lImage, forState: .Normal)
//        self.backButton.backgroundColor = UIColor.clearColor()
//        self.backButton.addTarget(self, action: #selector(CXSignInSignUpViewController.backAction), forControlEvents: .TouchUpInside)
//        
//        let navSpacer: UIBarButtonItem = UIBarButtonItem(barButtonSystemItem:UIBarButtonSystemItem.FixedSpace,target: nil, action: nil)
//        navSpacer.width = -16;
//        self.navigationItem.leftBarButtonItems = [navSpacer,UIBarButtonItem.init(customView: self.backButton)]
//        
//        
//        let tLabel : UILabel = UILabel()
//        tLabel.frame = CGRectMake(0, 0, 120, 40);
//        tLabel.backgroundColor = UIColor.clearColor()
//        tLabel.font = UIFont.init(name: "Roboto-Bold", size: 18)
//        tLabel.text = "Sign In"
//        tLabel.textAlignment = NSTextAlignment.Center
//        tLabel.textColor = UIColor.whiteColor()
//        self.navigationItem.titleView = tLabel
//        
//    }
    
    func customizeMainView() {
        self.cScrollView = UIScrollView.init(frame: CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-65))
        self.cScrollView.backgroundColor = UIColor.clearColor()
        self.cScrollView.contentSize = CGSizeMake(self.view.frame.size.width, 600)
        
        self.view.addSubview(self.cScrollView)
        
//        let logo: UILabel = UIImageView.init(frame: CGRectMake((self.view.frame.size.width - 50)/2, 5, 50, 50))
//        logo.image = UIImage(named: "smlogo.png")
//        self.cScrollView.addSubview(logo)
        
        let headerLbl : UILabel = UILabel()
        headerLbl.frame = CGRectMake((self.view.frame.size.width - 50)/2, 5, 50, 50);
        headerLbl.backgroundColor = UIColor.clearColor()
        headerLbl.font = UIFont.init(name: "Roboto-Regular", size:25)//25
        headerLbl.text = "Sign In"
        headerLbl.textAlignment = NSTextAlignment.Center
        headerLbl.textColor = UIColor.blackColor()
        self.cScrollView.addSubview(headerLbl)
        
        let hLabel : UILabel = UILabel()
        hLabel.frame = CGRectMake(20, headerLbl.frame.size.height+headerLbl.frame.origin.y+5, self.view.frame.size.width-40, 35);
        hLabel.backgroundColor = UIColor.clearColor()
        hLabel.font = UIFont.init(name: "Roboto-Regular", size:15)//25
        hLabel.text = "Sign in with your email address"
        hLabel.textAlignment = NSTextAlignment.Center
        hLabel.textColor = UIColor.blackColor()
        self.cScrollView.addSubview(hLabel)
        
        
        self.emailAddressField = self.createField(CGRectMake(30, hLabel.frame.size.height+hLabel.frame.origin.y+5, self.view.frame.size.width-60, 40), tag: 1, placeHolder: "Email address")
        self.cScrollView.addSubview(self.emailAddressField)
        
        self.passwordField = self.createField(CGRectMake(30, self.emailAddressField.frame.size.height+self.emailAddressField.frame.origin.y+20, self.view.frame.size.width-60, 40), tag: 2, placeHolder: "Password")
        self.passwordField.secureTextEntry = true
        self.cScrollView.addSubview(self.passwordField)
        
        self.signUpBtn = self.createButton(CGRectMake(25, self.passwordField.frame.size.height+self.passwordField.frame.origin.y+30, self.view.frame.size.width-50, 40), title: "SIGN UP", tag: 3, bgColor: UIColor.signUpColor())
       // self.signUpBtn.addTarget(self, action: #selector(CXSignUpViewController.signUpBtnAction), forControlEvents: .TouchUpInside)
        self.cScrollView.addSubview(self.signUpBtn)
        
        self.signInBtn = self.createButton(CGRectMake(25, self.signUpBtn.frame.size.height+self.signUpBtn.frame.origin.y+30, self.view.frame.size.width-50, 40), title: "SIGN IN", tag: 3, bgColor: UIColor.signInColor())
        self.signInBtn.addTarget(self, action: #selector(CXSignUpViewController.signInBtnAction), forControlEvents: .TouchUpInside)
        self.cScrollView.addSubview(self.signInBtn)
        
    }
//    
//    func loginButton(loginButton: FBSDKLoginButton!, didCompleteWithResult result: FBSDKLoginManagerLoginResult!, error: NSError!) {
//        print("Response \(result)")
//        FBSDKGraphRequest.init(graphPath: "me", parameters: ["fields":"first_name,email,last_name,gender,picture.type(large),id"]).startWithCompletionHandler { (connection, result, error) -> Void in
//            print ("FB Result is \(result)")
//            if result != nil {
//                let strFirstName: String = (result.objectForKey("first_name") as? String)!
//                let strLastName: String = (result.objectForKey("last_name") as? String)!
//                let userID: String = (result.objectForKey("id") as? String)!
//                let gender: String = (result.objectForKey("gender") as? String)!
//                let email: String = (result.objectForKey("email") as? String)!
//
//
//                self.profileImageStr = (result.objectForKey("picture")?.objectForKey("data")?.objectForKey("url") as? String)!
//                print("Welcome, \(strFirstName) \(strLastName) \(userID)")
//                
//                NSUserDefaults.standardUserDefaults().setObject(userID, forKey: "USER_ID")
//                NSUserDefaults.standardUserDefaults().setObject(email, forKey: "USER_EMAIL")
//                NSUserDefaults.standardUserDefaults().setObject(strFirstName, forKey: "FIRST_NAME")
//                NSUserDefaults.standardUserDefaults().setObject(strLastName, forKey: "LAST_NAME")
//                NSUserDefaults.standardUserDefaults().setObject(gender, forKey: "GENDER")
//                NSUserDefaults.standardUserDefaults().setObject(self.profileImageStr, forKey: "PROFILE_PIC")
//                NSUserDefaults.standardUserDefaults().synchronize()
//                self.showAlertView("Login successfully.", status: 1)
//            }
//                NSNotificationCenter.defaultCenter().postNotificationName("UpdateProfilePic", object: nil)
//        }
//    }
//    
//    
//    func loginButtonDidLogOut(loginButton: FBSDKLoginButton!) {
//        let loginManager: FBSDKLoginManager = FBSDKLoginManager()
//        loginManager.logOut()
//    }
//    
//    
//    // Google
//    
//    func signInWillDispatch(signIn: GIDSignIn!, error: NSError!) {
//        //  myActivityIndicator.stopAnimating()
//    }
//    
//    // Present a view that prompts the user to sign in with Google
//    func signIn(signIn: GIDSignIn!,
//                presentViewController viewController: UIViewController!) {
//        self.presentViewController(viewController, animated: true, completion: nil)
//    }
//    
//    // Dismiss the "Sign in with Google" view
//    func signIn(signIn: GIDSignIn!,
//                dismissViewController viewController: UIViewController!) {
//        self.dismissViewControllerAnimated(true, completion: nil)
//    }
//    
    
    func  createPlainTextButton(frame:CGRect,title: String,tag:Int) -> UIButton {
        let button: UIButton = UIButton()
        button.frame = frame
        button.setTitle(title, forState: .Normal)
        button.titleLabel?.font = UIFont.init(name:"Roboto-Regular", size: 15)
        button.titleLabel?.textAlignment = NSTextAlignment.Center
        button.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        button.backgroundColor = UIColor.clearColor()
        return button
        
    }
//    
//    func googleSignUp(notification: NSNotification){
//          self.showAlertView("Login successfully", status: 1)
//        //Take Action on Notification
//    }
//    
//    
    func showAlertView(message:String, status:Int) {
        dispatch_async(dispatch_get_main_queue(), {
            let alert = UIAlertController(title: "NV Agencies", message: message, preferredStyle: UIAlertControllerStyle.Alert)
            let okAction = UIAlertAction(title: "Okay", style: UIAlertActionStyle.Default) {
                UIAlertAction in
                if status == 1 {
                    if self.backButton.hidden {
                        //self.skipAction()
                    }else{
                        self.navigationController?.popViewControllerAnimated(true)
                    }
                }
            }
            alert.addAction(okAction)
            self.presentViewController(alert, animated: true, completion: nil)
        })
    }
    
//    func sendSignDetails() {
//        let signInUrl = "http://sillymonksapp.com:8081/MobileAPIs/loginConsumerForOrg?orgId="+orgID+"&email="+self.emailAddressField.text!+"&dt=DEVICES&password="+self.passwordField.text!
//        SMSyncService.sharedInstance.startSyncProcessWithUrl(signInUrl) { (responseDict) in
//            // print("Login response \(responseDict)")
//            
//            let status: Int = Int(responseDict.valueForKey("status") as! String)!
//            
//            if status == 1 {
//                NSUserDefaults.standardUserDefaults().setObject(responseDict.valueForKey("UserId"), forKey: "USER_ID")
//                NSUserDefaults.standardUserDefaults().setObject(responseDict.valueForKey("emailId"), forKey: "USER_EMAIL")
//                NSUserDefaults.standardUserDefaults().setObject(responseDict.valueForKey("firstName"), forKey: "FIRST_NAME")
//                NSUserDefaults.standardUserDefaults().setObject(responseDict.valueForKey("lastName"), forKey: "LAST_NAME")
//                NSUserDefaults.standardUserDefaults().setObject(responseDict.valueForKey("gender"), forKey: "GENDER")
//                NSUserDefaults.standardUserDefaults().setObject(nil, forKey: "PROFILE_PIC")
//                NSUserDefaults.standardUserDefaults().synchronize()
//                self.showAlertView("Login successfully", status: status)
//                
//            } else {
//                self.showAlertView("Please enter valid credentials", status: status)
//            }
//        }
//    }
    
//    func signInAction() {
//        // print ("Sign In action")
//        self.view.endEditing(true)
//        if self.isValidEmail(self.emailAddressField.text!) {
//            self.sendSignDetails()
//        } else {
//                let alert = UIAlertController(title: "Silly Monks", message: "Please enter valid email.", preferredStyle: UIAlertControllerStyle.Alert)
//                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
//                self.presentViewController(alert, animated: true, completion: nil)
//                //print("Please enter valid email")
//        }
//    }
    
    func signUpAction() {
        print ("Sign Up action")
        self.view.endEditing(true)
        let signUpView = CXSignUpViewController.init()
        //signUpView.orgID = self.orgID
        self.navigationController?.pushViewController(signUpView, animated: true)
    }
    
    func backAction() {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    func rightBtnAction() {
        
    }
    
    func isValidEmail(email: String) -> Bool {
        print("validate email: \(email)")
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        if emailTest.evaluateWithObject(email) {
            return true
        }
        return false
    }
    
    
    func createField(frame:CGRect, tag:Int, placeHolder:String) -> UITextField {
        let txtField : UITextField = UITextField()
        txtField.frame = frame;
        txtField.delegate = self
        txtField.tag = tag
        txtField.placeholder = placeHolder
        txtField.font = UIFont.init(name:"Roboto-Regular", size: 15)
        txtField.autocapitalizationType = .None
        let border = CALayer()
        let width = CGFloat(1.0)
        border.borderColor = UIColor.darkGrayColor().CGColor
        border.frame = CGRect(x: 0, y: txtField.frame.size.height - width, width:  txtField.frame.size.width, height: txtField.frame.size.height)
        border.borderWidth = width
        txtField.layer.addSublayer(border)
        txtField.layer.masksToBounds = true
        
        return txtField
    }
    
    func createButton(frame:CGRect,title: String,tag:Int, bgColor:UIColor) -> UIButton {
        let button: UIButton = UIButton()
        button.frame = frame
        button.setTitle(title, forState: .Normal)
        button.titleLabel?.font = UIFont.init(name:"Roboto-Regular", size: 15)
        button.layer.cornerRadius = 5.0
        button.layer.masksToBounds = true
        button.backgroundColor = bgColor
        return button
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        let scrollPoint = CGPointMake(0, textField.frame.origin.y)
        self.cScrollView.setContentOffset(scrollPoint, animated: true)
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        return textField.resignFirstResponder()
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        self.cScrollView.setContentOffset(CGPointZero, animated: true)
    }
}
