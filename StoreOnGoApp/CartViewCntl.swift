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

}


extension  CartViewCntl : UITableViewDelegate,UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.productsList.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let identifier = "CartITemCell"
        
        var cell: UITableViewCell! = tableView.dequeueReusableCellWithIdentifier(identifier) as? CartITemCell
        if cell == nil {
            cell = UITableViewCell(style: UITableViewCellStyle.Value1, reuseIdentifier: identifier)
        }
        let proListData : CX_Cart = self.productsList[indexPath.row] as! CX_Cart

        cell.selectionStyle = UITableViewCellSelectionStyle.None
        cell.textLabel?.text = proListData.name
        return cell;
    }

}

