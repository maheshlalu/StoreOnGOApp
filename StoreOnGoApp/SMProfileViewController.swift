//
//  SMProfileViewController.swift
//  SMSample
//
//  Created by CX_One on 7/28/16.
//  Copyright © 2016 CX_One. All rights reserved.
//

import UIKit

class SMProfileViewController: UIViewController {
    
    @IBOutlet var imgView: UIImageView!
    var strProfile : String!
    
    @IBOutlet var userEmailLbl: UILabel!
    
    @IBOutlet var fullNameLbl: UILabel!
    @IBOutlet var userFullName: UILabel!
    
    @IBOutlet weak var genderLbl: UILabel!
    @IBOutlet var userGender: UILabel!
    var imgURL: NSURL!
    var heder: UIView!
    @IBAction func favoritesBtnAction(sender: AnyObject) {
        
        let favoritesViewController:CartViewCntl = CartViewCntl.init()
        self.navigationController?.pushViewController(favoritesViewController, animated: true)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setDPImage()
        self.imgView.layer.cornerRadius = self.imgView.frame.size.width / 2
        self.imgView.clipsToBounds = true
        self.imgView.layer.borderWidth = 3.0
        self.imgView.layer.borderColor = UIColor.whiteColor().CGColor
        self.customizeHeaderView()
        
        // Do any additional setup after loading the view.
    }
    
    func customizeHeaderView() {
        self.navigationController?.navigationBar.translucent = false;
        self.navigationController?.navigationBar.barTintColor = UIColor.navBarColor()
        
        let lImage = UIImage(named: "leftArrow") as UIImage?
        let button = UIButton (type: UIButtonType.Custom) as UIButton
        button.frame = CGRectMake(0, 0, 40, 40)
        button.setImage(lImage, forState: .Normal)
        button.addTarget(self, action: #selector(SMProfileViewController.backAction), forControlEvents: .TouchUpInside)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: button)
        
        let tLabel : UILabel = UILabel()
        tLabel.frame = CGRectMake(0, 0, 120, 40);
        tLabel.backgroundColor = UIColor.clearColor()
        tLabel.font = UIFont.init(name: "Roboto-Bold", size: 18)
        tLabel.text = "MY PROFILE"
        tLabel.textAlignment = NSTextAlignment.Center
        tLabel.textColor = UIColor.whiteColor()
        self.navigationItem.titleView = tLabel
    }
    
    func backAction() {
        self.navigationController?.popViewControllerAnimated(true)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setDPImage() {
        self.strProfile = NSUserDefaults.standardUserDefaults().valueForKey("PROFILE_PIC") as? String
        if self.strProfile != nil{
            self.imgURL = NSURL(string: strProfile)!
            let request: NSURLRequest = NSURLRequest(URL: imgURL)
            NSURLConnection.sendAsynchronousRequest(
                request, queue: NSOperationQueue.mainQueue(),
                completionHandler: {(response: NSURLResponse?,data: NSData?,error: NSError?) -> Void in
                    if error == nil {
                        self.imgView.image = UIImage(data: data!)
                    }else{
                        
                    }
            })
        }else{
            
            self.imgView.image = UIImage(named: "profile_placeholder.png")
            
        }
        
        // self.setUserData()
    }
    
    func setUserData(){
        self.userFullName.text = (NSUserDefaults.standardUserDefaults().valueForKey("FIRST_NAME") as? String)!  + " " + (NSUserDefaults.standardUserDefaults().valueForKey("LAST_NAME") as? String)!
        self.fullNameLbl.text = self.userFullName.text
        self.userGender.text = NSUserDefaults.standardUserDefaults().valueForKey("GENDER") as? String
        self.userEmailLbl.text = NSUserDefaults.standardUserDefaults().valueForKey("USER_EMAIL") as? String
        
    }
    
    func showAlertView(message:String, status:Int) {
        let alert = UIAlertController(title: "NV Agencies", message: message, preferredStyle: UIAlertControllerStyle.Alert)
        //alert.addAction(UIAlertAction(title: "Okay", style: UIAlertActionStyle.Default, handler: nil))
        let okAction = UIAlertAction(title: "Okay", style: UIAlertActionStyle.Default) {
            UIAlertAction in
            if status == 1 {
                //self.navigationController?.popViewControllerAnimated(true)
            }
        }
        alert.addAction(okAction)
        //self.presentViewController(alert, animated: true, completion: nil)
    }
}
