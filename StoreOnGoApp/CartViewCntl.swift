//
//  CartViewCntl.swift
//  StoreOnGoApp
//
//  Created by Rama kuppa on 14/05/16.
//  Copyright © 2016 CX. All rights reserved.
//

import UIKit

class CartViewCntl: UIViewController {

    var cartTableView :  UITableView = UITableView()
    var  productsList :  NSMutableArray = NSMutableArray()
    var keepShoppingBtn : UIButton = UIButton()
    var chekOutBtn  : UIButton = UIButton()
    var presentWindow : UIWindow?
 
    var country:String!
    var city:String!
    var fullname:String!
    var mobile:String!
    var address:String!
    var email:String!
    var state:String!

    
    var heder: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = CXConstant.cartViewBgClor
        self.designHeaderView()
        self.designCartActionButton()
        self.createCartTableView()
        self.getProductsList()
        
        if NSUserDefaults.standardUserDefaults().valueForKey("USER_ID") == nil{
            print("Plese Login")
        }else{
            print("it has an user id")
            country =  NSUserDefaults.standardUserDefaults().valueForKey("COUNTRY") as! String?
            city = NSUserDefaults.standardUserDefaults().valueForKey("CITY") as! String
            fullname = NSUserDefaults.standardUserDefaults().valueForKey("FULL_NAME") as! String
            mobile = NSUserDefaults.standardUserDefaults().valueForKey("MOBILE") as! String
            address = NSUserDefaults.standardUserDefaults().valueForKey("ADDRESS") as! String
            email = NSUserDefaults.standardUserDefaults().valueForKey("USER_EMAIL") as! String
            state = NSUserDefaults.standardUserDefaults().valueForKey("STATE") as! String
        }
        
     
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func createCartTableView () {
        self.cartTableView = UITableView.init(frame: CGRectMake(0, CXConstant.headerViewHeigh, self.view.frame.size.width, self.view.frame.size.height-CXConstant.headerViewHeigh-100))
        self.cartTableView.contentInset =  UIEdgeInsetsMake(0, 0, 100, 0)
        self.cartTableView.dataSource = self
        self.cartTableView.delegate = self
        self.cartTableView.backgroundColor = UIColor.clearColor()
        self.cartTableView.registerClass(CartITemCell.self, forCellReuseIdentifier: "CartITemCell")
        //self.cartTableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "DetailCell")
        self.view.addSubview(self.cartTableView)
        self.cartTableView.tableFooterView = UIView()
        self.cartTableView.separatorStyle = UITableViewCellSeparatorStyle.None


    }
    
    func designHeaderView (){
        
        if NSUserDefaults.standardUserDefaults().valueForKey("USER_ID") != nil{
            heder =  CXHeaderView.init(frame: CGRectMake(0, 0, CXConstant.screenSize.width, CXConstant.headerViewHeigh), andTitle: "Cart List", andDelegate: self, backButtonVisible: true, cartBtnVisible: true,profileBtnVisible: true, isForgot: false ,isLogout:true)
        }else{
            heder = CXHeaderView.init(frame: CGRectMake(0, 0, CXConstant.screenSize.width, CXConstant.headerViewHeigh), andTitle: "Cart List", andDelegate: self, backButtonVisible: true, cartBtnVisible: true,profileBtnVisible: true, isForgot: false,isLogout:false)
        }
        self.view.addSubview(heder)
        
    }
    func getProductsList(){
        
        //let   predicate :   NSPredicate   = NSPredicate(format: "addToCart = 'YES'")
        let productEn = NSEntityDescription.entityForName("CX_Cart", inManagedObjectContext: NSManagedObjectContext.MR_contextForCurrentThread())
        let fetchRequest = CX_Cart.MR_requestAllSortedBy("name", ascending: true)
       // fetchRequest.predicate = predicate
        fetchRequest.entity = productEn
        self.productsList.addObjectsFromArray( CX_Cart.MR_executeFetchRequest(fetchRequest))
        self.cartTableView.reloadData()
        
    }
    
    /*
    // MARK: - Navigation
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    

}



extension  CartViewCntl : UITableViewDelegate,UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.productsList.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let identifier = "CartITemCell1222"
        
        var cell: UITableViewCell! = tableView.dequeueReusableCellWithIdentifier(identifier) as? CartITemCell
        if cell == nil {
            cell = UITableViewCell(style: UITableViewCellStyle.Value1, reuseIdentifier: identifier)
        }
        cell.selectionStyle = UITableViewCellSelectionStyle.None
        let proListData : CX_Cart = self.productsList[indexPath.row] as! CX_Cart
        

        
        cell.contentView.addSubview(self.createLabel(CXConstant.cartItemCodeLblFrame, titleString: proListData.itemCode!))
        cell.contentView.addSubview(self.createLabel(CXConstant.cartItemNameLblFrame, titleString: proListData.name!))
        cell.contentView.addSubview(self.createLabel(CXConstant.cartItemQuantityFrame, titleString: "Qty"))
        cell.contentView.addSubview(self.createTextFiled(CXConstant.cartItemtextFrame, title:CXDBSettings.sharedInstance.isAddToCart(proListData.pID!).totalCount as String,indexPtah: indexPath))

        cell.selectionStyle = UITableViewCellSelectionStyle.None
        
        return cell;
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return CXConstant.cartCellHeight
    }
    
    func createTextFiled (frame :  CGRect,title : NSString ,indexPtah : NSIndexPath) -> UITextField {
        
        let sampleTextField = UITextField(frame: CGRectMake(frame.origin.x, 13, frame.size.width, 25))
        sampleTextField.font =  UIFont(name:"Roboto-Regular",size:12)
        sampleTextField.borderStyle = UITextBorderStyle.Bezel
        sampleTextField.autocorrectionType = UITextAutocorrectionType.No
        sampleTextField.keyboardType = UIKeyboardType.NumbersAndPunctuation
        sampleTextField.returnKeyType = UIReturnKeyType.Done
        sampleTextField.contentVerticalAlignment = UIControlContentVerticalAlignment.Center
        sampleTextField.delegate = self
        sampleTextField.tag = indexPtah.row+1
        sampleTextField.text = title as String
        return sampleTextField
    }
    
    
    func createLabel(frame:CGRect ,titleString:NSString) -> UILabel {
        
        let textFrame =  CGRectMake(frame.origin.x, frame.origin.y+5, frame.size.width, frame.size.height)
        let  textLabel: UILabel = UILabel(frame: textFrame)
        // textLabel.font = UIFont.systemFontOfSize(UIFont.smallSystemFontSize())
        textLabel.textAlignment = .Center
        textLabel.font = UIFont(name:"Roboto-Regular",size:10)
        //textLabel.font = UIFont.boldSystemFontOfSize(13.0)
        textLabel.text = titleString as String
        textLabel.textColor = UIColor.blackColor()
        textLabel.numberOfLines = 0
        return textLabel
    }
    
    
    func designCartActionButton(){
        
        
        self.keepShoppingBtn = CXConstant.sharedInstance.CrateButton(CGRectMake(20, CXConstant.screenSize.height - 110, CXConstant.screenSize.width-40, 50), titleString: "Keep shopping", backGroundColor: CXConstant.keepShoppingBtnColor,font : UIFont(name:"Roboto-Regular",size:13)!)
        
        keepShoppingBtn.addTarget(self, action: #selector(CartViewCntl.keepShoppingBtnAction(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        
        
        self.chekOutBtn = CXConstant.sharedInstance.CrateButton(CGRectMake(20, CXConstant.screenSize.height - 65, CXConstant.screenSize.width-40, 50), titleString: "Check out now", backGroundColor: CXConstant.checkOutBtnColor,font : UIFont(name:"Roboto-Regular",size:13)!)
        chekOutBtn.addTarget(self, action: #selector(CartViewCntl.checkOutBtnAction(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        
        
        self.view.addSubview(self.keepShoppingBtn)
        self.view.addSubview(self.chekOutBtn)
        
        
        
    }
    
    func keepShoppingBtnAction(button : UIButton!){
        
        self.navigationController?.popViewControllerAnimated(true)
        
    }
    
    
    func checkOutBtnAction(button : UIButton!){
         if NSUserDefaults.standardUserDefaults().valueForKey("USER_ID") != nil{
            self.sendTheCartItemsToServer()
         }else{
            let signUp : CXSignInSignUpViewController = CXSignInSignUpViewController.init()
            self.navigationController?.pushViewController(signUp, animated: false)
        }
        //UserDetailsCnt
    }
    
    func alertWithMessage(alertMessage:String){
        
        let alert = UIAlertController(title: "NV Agencies", message:alertMessage, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "Okay", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
        
    }

    
    func sendTheCartItemsToServer(){
        var urlString : String = "http://storeongo.com:8081/MobileAPIs/postedJobs?type=PlaceOrder"
        //"http://storeongo.com:8081/MobileAPIs/postedJobs?type=PlaceOrder&json="
        
        urlString = urlString.stringByAppendingString("&json="+(self.checkOutCartItems()))
        urlString = urlString.stringByAppendingString("&dt=CAMPAIGNS")
        urlString = urlString.stringByAppendingString("&category=Services")
        urlString = urlString.stringByAppendingString("&userId="+CXConstant.MallID)
        urlString = urlString.stringByAppendingString("&consumerEmail="+self.email)//self.email
        //{"list":[{"Address":"madhapur hyd","Name":"kushal","Contact_Number":"7893335553"}]})
        
        //print("Url Encoded string is \(urlString.URLEncodedString)")
        let url: NSURL = NSURL(string: urlString.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)!)!
        
        
        //SMSyncService.sharedInstance.startSyncWithUrl(urlString as String)
        
        //let url: NSURL = NSURL(string: urlString as String)!
        let request1: NSURLRequest = NSURLRequest(URL: url)
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithRequest(request1) { (resData:NSData?, response:NSURLResponse?, error:NSError?) -> Void in
            var jsonData : NSDictionary = NSDictionary()
            do {
                jsonData = try NSJSONSerialization.JSONObjectWithData(resData!, options:NSJSONReadingOptions.MutableContainers ) as! NSDictionary
            } catch {
                print("Error in parsing")
            }
            let string = jsonData.valueForKeyPath("myHashMap.status")
            if ((string?.rangeOfString("1")) != nil){
                print("All Malls \(jsonData)")
                
                let fetchRequest = NSFetchRequest(entityName: "CX_Cart")
                let cartsDataArrya : NSArray = CX_Cart.MR_executeFetchRequest(fetchRequest)
                
                for (index, element) in cartsDataArrya.enumerate() {
                    let cart : CX_Cart = element as! CX_Cart
                    NSManagedObjectContext.MR_contextForCurrentThread().deleteObject(cart)
                    NSManagedObjectContext.MR_contextForCurrentThread().MR_saveToPersistentStoreAndWait()
                }
                 dispatch_async(dispatch_get_main_queue(), {
                NSNotificationCenter.defaultCenter().postNotificationName("updateCartBtnAction", object: nil)
                })
                
            }
        }
        self.navigationController?.popToRootViewControllerAnimated(true)
        // NSNotificationCenter.defaultCenter().postNotificationName("updateCartBtnAction", object: nil)
        
        task.resume()
        
        //startSyncWithUrl
        /* http://storeongo.com:8081/MobileAPIs/postedJobs?type=PlaceOrder&json={"list":[{"OrderItemName":"GRIP ACC [RH] KB BOXER/CALIBER N/M`13501630|STICKER SET TVS VICTOR [BLACK TANK]`14075630|STICKER SET TVS VICTOR [BLUE TANK]`14075740|STICKER SET TVS VICTOR [GREEN TANK]`14075840","Total":"","OrderItemQuantity":"30`13501630|30`14075630|40`14075740|40`14075840","OrderItemSubTotal":"0.0`13501630|0.0`14075630|0.0`14075740|0.0`14075840","OrderItemId":"135016`13501630|140756`14075630|140757`14075740|140758`14075840","Contact_Number":"7893335553","OrderItemMRP":"`13501630|`14075630|`14075740|`14075840","Address":"madhapur hyd","Name":"kushal"}]}&dt=CAMPAIGNS&category=Services&userId=4452&consumerEmail=cxsample@gmail.com*/
        
    }

    
    func checkOutCartItems()-> String{
        let productEn = NSEntityDescription.entityForName("CX_Cart", inManagedObjectContext: NSManagedObjectContext.MR_contextForCurrentThread())
        let fetchRequest = CX_Cart.MR_requestAllSortedBy("name", ascending: true)
        // fetchRequest.predicate = predicate
        fetchRequest.entity = productEn
        
        let order: NSMutableDictionary = NSMutableDictionary()
        var orderItemName: NSMutableString = NSMutableString()
        let orderItemQuantity: NSMutableString = NSMutableString()
        let orderSubTotal: NSMutableString = NSMutableString()
        let orderItemId: NSMutableString = NSMutableString()
        let orderItemMRP: NSMutableString = NSMutableString()
        
        //let total: Double = 0
        order.setValue(self.fullname, forKey: "Name")
        //order["Name"] = ("\("kushal")")
        //should be replaced
        // order["Address"] = ("\("madhapur hyd")")
        order.setValue(self.address, forKey: "Address")
        
        //should be replaced
        //order["Contact_Number"] = ("\("7893335553")")
        order.setValue(self.mobile, forKey: "Contact_Number")
        
        //should be replaced
        
        
        for (index, element) in CX_Cart.MR_executeFetchRequest(fetchRequest).enumerate() {
            let cart : CX_Cart = element as! CX_Cart
            if index != 0 {
                orderItemName.appendString(("\("|")"))
                orderItemQuantity .appendString(("\("|")"))
                orderSubTotal .appendString(("\("|")"))
                orderItemId .appendString(("\("|")"))
                orderItemMRP .appendString(("\("|")"))
            }
            orderItemName.appendString("\(cart.name! + "`" + cart.pID!)")
            orderItemQuantity.appendString("\(cart.quantity! + "`" + cart.pID!)")
            //orderSubTotal.appendString(cart.name! + "`" + cart.pID!)
            orderItemId.appendString("\(cart.pID! + "`" + cart.pID!)")
            //orderItemMRP.appendString(cart.name! + "`" + cart.pID!)
            print("Item \(index): \(cart)")
        }
        
        //  order["OrderItemId"] = orderItemId
        order.setValue(orderItemId, forKey: "OrderItemId")
        
        //[order setObject:itemCode forKey:@"ItemCode"];
        //order["OrderItemQuantity"] = orderItemQuantity
        order.setValue(orderItemQuantity, forKey: "OrderItemQuantity")
        
        // order["OrderItemName"] = orderItemName
        order.setValue(orderItemName, forKey: "OrderItemName")
        
        //order["OrderItemSubTotal"] = ("\(orderSubTotal)")
        order.setValue(orderSubTotal, forKey: "OrderItemSubTotal")
        
        // order["OrderItemMRP"] = ("\(orderItemMRP)")
        order.setValue(orderItemMRP, forKey: "OrderItemMRP")
        
        
        print("order dic \(order)")
        
        let listArray : NSMutableArray = NSMutableArray()
        
        listArray.addObject(order)
        
        let cartJsonDict :NSMutableDictionary = NSMutableDictionary()
        cartJsonDict.setObject(listArray, forKey: "list")
        
        //let jsonString = cartJsonDict.JSONString()
        var jsonData : NSData = NSData()
        do {
            jsonData = try NSJSONSerialization.dataWithJSONObject(cartJsonDict, options: NSJSONWritingOptions.PrettyPrinted)
            // here "jsonData" is the dictionary encoded in JSON data
        } catch let error as NSError {
            print(error)
        }
        let jsonStringFormat = String(data: jsonData, encoding: NSUTF8StringEncoding)
        print("order dic \(jsonStringFormat)")
        
        return jsonStringFormat!
        
        
        
        // println("JSON string = \(theJSONText!)")
        
        /*
         {
         "list":[
         {
         "OrderItemName":"GRIP ACC [RH] KB BOXER/CALIBER N/M`13501630|STICKER SET TVS VICTOR [BLACK TANK]`14075630|STICKER SET TVS VICTOR [BLUE TANK]`14075740|STICKER SET TVS VICTOR [GREEN TANK]`14075840",
         "Total":"",
         "OrderItemQuantity":"30`13501630|30`14075630|40`14075740|40`14075840",
         "OrderItemSubTotal":"0.0`13501630|0.0`14075630|0.0`14075740|0.0`14075840",
         "OrderItemId":"135016`13501630|140756`14075630|140757`14075740|140758`14075840",
         "Contact_Number":"7893335553",
         "OrderItemMRP":"`13501630|`14075630|`14075740|`14075840",
         "Address":"madhapur hyd",
         "Name":"kushal"
         }
         ]
         }
         
         
         http://storeongo.com:8081/MobileAPIs/postedJobs?type=PlaceOrder&json={"list":[{"OrderItemName":"GRIP ACC [RH] KB BOXER/CALIBER N/M`13501630|STICKER SET TVS VICTOR [BLACK TANK]`14075630|STICKER SET TVS VICTOR [BLUE TANK]`14075740|STICKER SET TVS VICTOR [GREEN TANK]`14075840","Total":"","OrderItemQuantity":"30`13501630|30`14075630|40`14075740|40`14075840","OrderItemSubTotal":"0.0`13501630|0.0`14075630|0.0`14075740|0.0`14075840","OrderItemId":"135016`13501630|140756`14075630|140757`14075740|140758`14075840","Contact_Number":"7893335553","OrderItemMRP":"`13501630|`14075630|`14075740|`14075840","Address":"madhapur hyd","Name":"kushal"}]}&dt=CAMPAIGNS&category=Services&userId=4452&consumerEmail=cxsample@gmail.com
         
         */
        
    }

    

}


extension CartViewCntl : HeaderViewDelegate {
    
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
        let profile : CXProfilePageView = CXProfilePageView.init()
        self.navigationController?.pushViewController(profile, animated: false)
    }
    
    func userLogout() {
        alertWithMessage("User Logout Successfully!")
        designHeaderView()
    }
    
}

extension CartViewCntl : UITextFieldDelegate {
    
    func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
        print("TextField should begin editing method called")
        return true;
    }
    
    func textFieldShouldClear(textField: UITextField) -> Bool {
        print("TextField should clear method called")
        return true;
    }
    
    func textFieldShouldEndEditing(textField: UITextField) -> Bool {
        print("TextField should snd editing method called")
        return true;
    }
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        print("While entering the characters this method gets called")
        let aSet = NSCharacterSet(charactersInString:"0123456789").invertedSet
        let compSepByCharInSet = string.componentsSeparatedByCharactersInSet(aSet)
        let numberFiltered = compSepByCharInSet.joinWithSeparator("")
        return string == numberFiltered
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if ((textField.text?.isEmpty) != nil) {
            let indexPath = NSIndexPath(forRow: textField.tag-1, inSection: 0)
            let cell = self.cartTableView.cellForRowAtIndexPath(indexPath)
            let textField : UITextField = cell?.contentView.viewWithTag(textField.tag) as! UITextField
            let cartData : CX_Cart = self.productsList[indexPath.row] as! CX_Cart
            cartData.quantity = textField.text!
            NSManagedObjectContext.MR_contextForCurrentThread().MR_saveOnlySelfAndWait()
            self.cartTableView.reloadRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        }else{
            presentWindow?.makeToast(message: "Please enter quantity value")
        }
        textField.resignFirstResponder();
        return true;
    }
    
    
    /*
     let productEn = NSEntityDescription.entityForName("TABLE_PRODUCT_SUB_CATEGORIES", inManagedObjectContext: NSManagedObjectContext.MR_contextForCurrentThread())
     let fetchRequest = TABLE_PRODUCT_SUB_CATEGORIES.MR_requestAllSortedBy("name", ascending: true)
     var predicate:NSPredicate = NSPredicate()
     
     if isProductCategory {
     predicate = NSPredicate(format: "masterCategory = %@ AND name contains[c] %@", "Products List(129121)",self.searchBar.text!)
     }else{
     predicate = NSPredicate(format: "masterCategory = %@ AND name contains[c] %@", "Miscellaneous(135918)",self.searchBar.text!)
     }
     
     fetchRequest.predicate = predicate
     fetchRequest.entity = productEn
     
     self.productCategories =   TABLE_PRODUCT_SUB_CATEGORIES.MR_executeFetchRequest(fetchRequest)
     
     self.productCollectionView.reloadData()
     
     */
    
}



