//
//  UserDetailsCnt.swift
//  StoreOnGoApp
//
//  Created by Mahesh Y on 26/05/16.
//  Copyright © 2016 CX. All rights reserved.
//

import UIKit

class UserDetailsCnt: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.sendTheCartItemsToServer()
        // Do any additional setup after loading the view.
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
        

        
        var urlString : NSString = "http://storeongo.com:8081/MobileAPIs/postedJobs?type=PlaceOrder"
        //"http://storeongo.com:8081/MobileAPIs/postedJobs?type=PlaceOrder&json="
        
        urlString = urlString.stringByAppendingString("&json=" + self.checkOutCartItems())
        urlString = urlString.stringByAppendingString("&dt=CAMPAIGNS")
        urlString = urlString.stringByAppendingString("&category=Services")
        urlString = urlString.stringByAppendingString("&userId="+CXConstant.MallID)
        urlString = urlString.stringByAppendingString("&consumerEmail="+"yernagulamahesh@gmail.com")

        
       // let reqUrl = CXConstant.addToCartItemUrl+self.checkOutCartItems()+"&dt=CAMPAIGNS&category=Services&userId="+CXConstant.MallID+"&consumerEmail="+"yernagulamahesh@gmail.com"
            
        //print ("Req URL \(reqUrl)")
        
//        SMSyncService.sharedInstance.startSyncProcessWithUrl(urlString as String) { (responseDict) -> Void in
//             print ("stores   response   data \(responseDict) ")
//        }
        
         SMSyncService.sharedInstance.startSyncWithUrl(urlString as String)
        //startSyncWithUrl
      /*
         "http://storeongo.com:8081/MobileAPIs/postedJobs?type=PlaceOrder&json={"list":[{"OrderItemId":"NAJ0906`135015","OrderItemQuantity":"2`135015","OrderItemSubTotal":"","OrderItemMRP":"","Address":"madhapur hyd","Contact_Number":"7893335553","Name":"kushal","OrderItemName":"ACC GRIP HOUSING LOWER HH/SPLENDOR`135015"}]}&dt=CAMPAIGNS&category=Services&userId=4452&consumerEmail=yernagulamahesh@hmail.com"
         
         http://storeongo.com:8081/MobileAPIs/postedJobs?type=PlaceOrder&json={"list":[{"Address":"madhapur hyd","OrderItemSubTotal":"","OrderItemMRP":"","Name":"kushal","Contact_Number":"7893335553","OrderItemId":"135033`135033","OrderItemQuantity":"33`135033","OrderItemName":"ACC GRIP TVS XL`135033"}]}&dt=CAMPAIGNS&category=Services&userId=4452&consumerEmail=yernagulamahesh@gmail.com
         
         http://storeongo.com:8081/MobileAPIs/postedJobs?type=PlaceOrder&json={"list":[{"Address":"madhapur hyd","OrderItemSubTotal":"","OrderItemMRP":"","Name":"kushal","Contact_Number":"7893335553","OrderItemId":"135033`135033","OrderItemQuantity":"33`135033","OrderItemName":"ACC GRIP TVS XL`135033"}]}&dt=CAMPAIGNS&category=Services&userId=4452&consumerEmail=yernagulamahesh@gmail.com
         
         
         */
        
                /* http://storeongo.com:8081/MobileAPIs/postedJobs?type=PlaceOrder&json={"list":[{"OrderItemName":"GRIP ACC [RH] KB BOXER/CALIBER N/M`13501630|STICKER SET TVS VICTOR [BLACK TANK]`14075630|STICKER SET TVS VICTOR [BLUE TANK]`14075740|STICKER SET TVS VICTOR [GREEN TANK]`14075840","Total":"","OrderItemQuantity":"30`13501630|30`14075630|40`14075740|40`14075840","OrderItemSubTotal":"0.0`13501630|0.0`14075630|0.0`14075740|0.0`14075840","OrderItemId":"135016`13501630|140756`14075630|140757`14075740|140758`14075840","Contact_Number":"7893335553","OrderItemMRP":"`13501630|`14075630|`14075740|`14075840","Address":"madhapur hyd","Name":"kushal"}]}&dt=CAMPAIGNS&category=Services&userId=4452&consumerEmail=cxsample@gmail.com*/
        
    }
    
    
    func checkOutCartItems()-> String{
        
        
        let productEn = NSEntityDescription.entityForName("CX_Cart", inManagedObjectContext: NSManagedObjectContext.MR_contextForCurrentThread())
        let fetchRequest = CX_Cart.MR_requestAllSortedBy("name", ascending: true)
        // fetchRequest.predicate = predicate
        fetchRequest.entity = productEn
        
        let order: NSMutableDictionary = NSMutableDictionary()
        let orderItemName: NSMutableString = NSMutableString()
        //NSMutableString* itemCode = [NSMutableString string];
        let orderItemQuantity: NSMutableString = NSMutableString()
        let orderSubTotal: NSMutableString = NSMutableString()
        let orderItemId: NSMutableString = NSMutableString()
        let orderItemMRP: NSMutableString = NSMutableString()
        
        let total: Double = 0
        
        order["Name"] = ("\("kushal")")
        //should be replaced
        order["Address"] = ("\("madhapur hyd")")
        //should be replaced
        order["Contact_Number"] = ("\("7893335553")")
        //should be replaced
        
        
        for (index, element) in CX_Cart.MR_executeFetchRequest(fetchRequest).enumerate() {
            let cart : CX_Cart = element as! CX_Cart
            if index != 0 {
                orderItemName .appendString(("\("|")"))
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
        
        order["OrderItemId"] = orderItemId
        //[order setObject:itemCode forKey:@"ItemCode"];
        order["OrderItemQuantity"] = orderItemQuantity
        order["OrderItemName"] = orderItemName
        order["OrderItemSubTotal"] = ("\(orderSubTotal)")
        order["OrderItemMRP"] = ("\(orderItemMRP)")
        
        print("order dic \(order)")
        
        let listArray : NSMutableArray = NSMutableArray()
        listArray.addObject(order)
        
        let cartJsonDict :NSMutableDictionary = NSMutableDictionary()
        cartJsonDict.setObject(listArray, forKey: "list")
    
        let jsonString = cartJsonDict.JSONString()

       print("order dic \(jsonString)")
    

        return jsonString

       
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
