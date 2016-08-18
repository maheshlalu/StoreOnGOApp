//
//  UserDetailsCnt.swift
//  StoreOnGoApp
//
//  Created by Mahesh Y on 26/05/16.
//  Copyright © 2016 CX. All rights reserved.
//

import UIKit
import AVFoundation

class UserDetailsCnt: UIViewController {

    var userNameText : UITextField = UITextField()
    var emailText : UITextField = UITextField()
    var address1Text   : UITextField = UITextField()
    var addres2Text : UITextField = UITextField()
    var phoneText : UITextField = UITextField()
    var cartTableView :  UITableView = UITableView()
    let productsList: [String] = ["Name", "Email address","Address line1","Address line2","Phone number",""]

    override func viewDidLoad() {
        super.viewDidLoad()
        //self.sendTheCartItemsToServer()
        self.view.backgroundColor = CXConstant.cartViewBgClor
        self.designHeaderView()
        self.createCartTableView()
        // Do any additional setup after loading the view.
    }
    
    func designHeaderView (){
        
        let heder: UIView =  CXHeaderView.init(frame: CGRectMake(0, 0, CXConstant.screenSize.width, CXConstant.headerViewHeigh), andTitle: "User Details", andDelegate: self, backButtonVisible: true, cartBtnVisible: false ,profileBtnVisible: true)
        
        self.view.addSubview(heder)
    }
    func creationTextField(){
        
        
        
    }

    func createCartTableView () {
        self.cartTableView = UITableView.init(frame: CGRectMake(0, CXConstant.headerViewHeigh, self.view.frame.size.width, self.view.frame.size.height-CXConstant.headerViewHeigh-100))
        self.cartTableView.dataSource = self
        self.cartTableView.delegate = self
        self.cartTableView.backgroundColor = UIColor.clearColor()
        //self.cartTableView.registerClass(uita.self, forCellReuseIdentifier: "CartITemCell")
        self.cartTableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "DetailCell")
        self.view.addSubview(self.cartTableView)
        self.cartTableView.tableFooterView = UIView()
        self.cartTableView.separatorStyle = UITableViewCellSeparatorStyle.None
        
    }
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    
    func sendTheCartItemsToServer(){
        var urlString : String = "http://storeongo.com:8081/MobileAPIs/postedJobs?type=PlaceOrder"
        //"http://storeongo.com:8081/MobileAPIs/postedJobs?type=PlaceOrder&json="
        
        urlString = urlString.stringByAppendingString("&json="+(self.checkOutCartItems()))
        urlString = urlString.stringByAppendingString("&dt=CAMPAIGNS")
        urlString = urlString.stringByAppendingString("&category=Services")
        urlString = urlString.stringByAppendingString("&userId="+CXConstant.MallID)
        urlString = urlString.stringByAppendingString("&consumerEmail="+self.emailText.text!)
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
                NSNotificationCenter.defaultCenter().postNotificationName("updateCartBtnAction", object: nil)

                
            }
        }
        self.navigationController?.popToRootViewControllerAnimated(true)
       // NSNotificationCenter.defaultCenter().postNotificationName("updateCartBtnAction", object: nil)

        task.resume()
        
        //startSyncWithUrl
        /* http://storeongo.com:8081/MobileAPIs/postedJobs?type=PlaceOrder&json={"list":[{"OrderItemName":"GRIP ACC [RH] KB BOXER/CALIBER N/M`13501630|STICKER SET TVS VICTOR [BLACK TANK]`14075630|STICKER SET TVS VICTOR [BLUE TANK]`14075740|STICKER SET TVS VICTOR [GREEN TANK]`14075840","Total":"","OrderItemQuantity":"30`13501630|30`14075630|40`14075740|40`14075840","OrderItemSubTotal":"0.0`13501630|0.0`14075630|0.0`14075740|0.0`14075840","OrderItemId":"135016`13501630|140756`14075630|140757`14075740|140758`14075840","Contact_Number":"7893335553","OrderItemMRP":"`13501630|`14075630|`14075740|`14075840","Address":"madhapur hyd","Name":"kushal"}]}&dt=CAMPAIGNS&category=Services&userId=4452&consumerEmail=cxsample@gmail.com*/
        
    }
    
    func checkOutItems() -> String {
        var requestDictionary:NSMutableDictionary = NSMutableDictionary()
        var listItemsArray: NSMutableArray = NSMutableArray()
        
        let orderItemsDictionary : NSMutableDictionary = NSMutableDictionary()
        orderItemsDictionary.setValue("kushal", forKey: "Name")
        orderItemsDictionary.setValue("madhapur hyd", forKey: "Address")
        orderItemsDictionary.setValue("7893335553", forKey: "Contact_Number")
        
        listItemsArray.addObject(orderItemsDictionary)
        requestDictionary.setValue(listItemsArray, forKey: "list")
        
        var jsonData : NSData = NSData()
        do {
            jsonData = try NSJSONSerialization.dataWithJSONObject(requestDictionary, options: NSJSONWritingOptions.PrettyPrinted)
            // here "jsonData" is the dictionary encoded in JSON data
        } catch let error as NSError {
            print(error)
        }
        let theJSONText = NSString(data: jsonData,encoding: NSASCIIStringEncoding)
        print("JSON string = \(theJSONText!)")
        
        let jsonReqString = String(data: jsonData, encoding: NSUTF8StringEncoding)
        print("Data string is \(jsonReqString)");
        let jsonString = requestDictionary.JSONString()
        print("Requested \(jsonString))")
        return jsonReqString!
        
        
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
        order.setValue(self.userNameText.text, forKey: "Name")
        //order["Name"] = ("\("kushal")")
        //should be replaced
       // order["Address"] = ("\("madhapur hyd")")
        order.setValue(self.address1Text.text, forKey: "Address")

        //should be replaced
        //order["Contact_Number"] = ("\("7893335553")")
       order.setValue(self.phoneText.text, forKey: "Contact_Number")

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


extension  UserDetailsCnt : UITableViewDelegate,UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.productsList.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        // let cell:UITableViewCell = tableView.dequeueReusableCellWithIdentifier("DetailCell", forIndexPath: indexPath) as UITableViewCell
        
        var cell = tableView.dequeueReusableCellWithIdentifier("DetailCell") as UITableViewCell!
        if (cell == nil) {
            cell = UITableViewCell(style:.Default, reuseIdentifier: "DetailCell")
        }
        
        cell.selectionStyle = UITableViewCellSelectionStyle.None
        cell.backgroundView?.backgroundColor = UIColor.clearColor()
        cell.backgroundColor = UIColor.clearColor()
        cell.selectionStyle = UITableViewCellSelectionStyle.None
        switch indexPath.row {
        case 0:
              self.userNameText = self.createTextFiled(CGRectMake(10, 0, tableView.frame.size.width-25, 50), title: "", indexPtah: indexPath, placeHolder: productsList[indexPath.row])
              [cell.contentView .addSubview(self.userNameText)];
            break
        case 1:
            self.emailText = self.createTextFiled(CGRectMake(10, 0, tableView.frame.size.width-25, 50), title: "", indexPtah: indexPath, placeHolder: productsList[indexPath.row])
            [cell.contentView .addSubview(self.emailText)];
            break
        case 2:
            self.address1Text = self.createTextFiled(CGRectMake(10, 0, tableView.frame.size.width-25, 50), title: "", indexPtah: indexPath, placeHolder: productsList[indexPath.row])
            [cell.contentView .addSubview(self.address1Text)];
            break
        case 3:
            self.addres2Text = self.createTextFiled(CGRectMake(10, 0, tableView.frame.size.width-25, 50), title: "", indexPtah: indexPath, placeHolder: productsList[indexPath.row])
            [cell.contentView .addSubview(self.addres2Text)];
            break
        case 4:
            self.phoneText = self.createTextFiled(CGRectMake(10, 0, tableView.frame.size.width-25, 50), title: "", indexPtah: indexPath, placeHolder: productsList[indexPath.row])
            [cell.contentView .addSubview(self.phoneText)];
            break
        case 5:
            let okButton : UIButton = CXConstant.sharedInstance.CrateButton(CGRectMake(10, 0, tableView.frame.size.width-25, 50), titleString: "OK", backGroundColor: CXConstant.keepShoppingBtnColor,font : UIFont(name:"Roboto-Regular",size:13)!)
            [cell.contentView .addSubview(okButton)];
            okButton.addTarget(self, action: #selector(UserDetailsCnt.okButtonAction(_:)), forControlEvents: UIControlEvents.TouchUpInside)
            break
        default: break
            
        }
        
        
        return cell;
    }
    
    func okButtonAction (button : UIButton!){

        
        if !(self.userNameText.text?.isEmpty)! && !(self.emailText.text?.isEmpty)! && !(self.address1Text.text?.isEmpty)! && !(self.addres2Text.text?.isEmpty)! && !(self.phoneText.text?.isEmpty)!{
            self.sendTheCartItemsToServer()
        }else{
            
        }
        
       // self.navigationController?.popViewControllerAnimated(true)

    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 60
    }
    
    
    func createTextFiled (frame :  CGRect,title : NSString ,indexPtah : NSIndexPath,placeHolder :  NSString) -> UITextField {
        
        let sampleTextField = UITextField(frame: CGRectMake(frame.origin.x, 10, frame.size.width, frame.size.height))
        sampleTextField.font =  UIFont(name:"Roboto-Regular",size:13)
        sampleTextField.borderStyle = UITextBorderStyle.Bezel
        sampleTextField.autocorrectionType = UITextAutocorrectionType.No
        sampleTextField.keyboardType = UIKeyboardType.NumbersAndPunctuation
        sampleTextField.returnKeyType = UIReturnKeyType.Done
        sampleTextField.contentVerticalAlignment = UIControlContentVerticalAlignment.Center
        sampleTextField.delegate = self
        sampleTextField.tag = indexPtah.row+1
        sampleTextField.placeholder = placeHolder as String
        sampleTextField.text = title as String
        return sampleTextField
    }
    
    
    
    
}

extension UserDetailsCnt : UITextFieldDelegate{
    
    func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
        //print("TextField should begin editing method called")
        return true;
    }
    
    func textFieldShouldClear(textField: UITextField) -> Bool {
        //print("TextField should clear method called")
        return true;
    }
    
    func textFieldShouldEndEditing(textField: UITextField) -> Bool {
        //print("TextField should snd editing method called")
        return true;
    }
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        //print("While entering the characters this method gets called")
        return true;
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        if ((textField.text?.isEmpty) != nil) {
        }
        
        
        //print("button tag %d\(textField.tag)")
        //print("TextField should return method called")
        textField.resignFirstResponder();
        return true;
    }
}


extension UserDetailsCnt : HeaderViewDelegate {
    
    func backButtonAction (){
        self.navigationController?.popViewControllerAnimated(true)
    }
    func presentViewController(popUpView: CAPopUpViewController!) {
        self.presentViewController(popUpView, animated: true) {
            
        }
    }
    
    func cartButtonAction(){
       
        
    }
    func navigationProfileandLogout(isProfile: Bool) {
        let profile : CXSignInSignUpViewController = CXSignInSignUpViewController.init()
        self.navigationController?.pushViewController(profile, animated: false)
    }
    
}
