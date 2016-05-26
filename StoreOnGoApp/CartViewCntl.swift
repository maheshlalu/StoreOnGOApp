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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.grayColor()
        self.createCartTableView()
        self.getProductsList()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func createCartTableView () {
        self.cartTableView = UITableView.init(frame: self.view.frame)
        self.cartTableView.dataSource = self
        self.cartTableView.delegate = self
        self.cartTableView.backgroundColor = UIColor.whiteColor()
        self.cartTableView.registerClass(CartITemCell.self, forCellReuseIdentifier: "CartITemCell")
        //self.cartTableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "DetailCell")
        self.view.addSubview(self.cartTableView)
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
    
    
    func checkOutCartItems(){
        
        
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
        
        order["Name"] = "kushal"
        //should be replaced
        order["Address"] = "madhapur hyd"
        //should be replaced
        order["Contact_Number"] = "7893335553"
        //should be replaced
        
        
        for (index, element) in CX_Cart.MR_executeFetchRequest(fetchRequest).enumerate() {
            let cart : CX_Cart = element as! CX_Cart
            if index != 0 {
                orderItemName .appendString("|")
                orderItemQuantity .appendString("|")
                orderSubTotal .appendString("|")
                orderItemId .appendString("|")
                orderItemMRP .appendString("|")
            }
            orderItemName.appendString(cart.name! + "`" + cart.pID!)
            orderItemQuantity.appendString(cart.quantity! + "`" + cart.pID!)
            //orderSubTotal.appendString(cart.name! + "`" + cart.pID!)
            orderItemId.appendString(cart.itemCode! + "`" + cart.pID!)
            //orderItemMRP.appendString(cart.name! + "`" + cart.pID!)
            print("Item \(index): \(cart)")
        }
        
        order["OrderItemId"] = orderItemId
        //[order setObject:itemCode forKey:@"ItemCode"];
        order["OrderItemQuantity"] = orderItemQuantity
        order["OrderItemName"] = orderItemName
        order["OrderItemSubTotal"] = orderSubTotal
        order["OrderItemMRP"] = orderItemMRP
        
        print("order dic \(order)")
        
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
         */
        
    }

}



extension  CartViewCntl : UITableViewDelegate,UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.productsList.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let identifier = "CartITemCell"
        
        var cell: CartITemCell! = tableView.dequeueReusableCellWithIdentifier(identifier) as? CartITemCell
        if cell == nil {
            cell = CartITemCell(style: UITableViewCellStyle.Value1, reuseIdentifier: identifier)
        }
        let proListData : CX_Cart = self.productsList[indexPath.row] as! CX_Cart

        cell.selectionStyle = UITableViewCellSelectionStyle.None
        cell.cartItemNameLbl.text = proListData.name
        
        return cell;
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 90
    }

}

