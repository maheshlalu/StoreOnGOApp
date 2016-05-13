//
//  ProductListCntl.swift
//  StoreOnGoApp
//
//  Created by Rama kuppa on 03/05/16.
//  Copyright © 2016 CX. All rights reserved.
//
//#import "MMSpreadsheetView.h"

import UIKit

class ProductListCntl: UIViewController {

    var productsList : NSArray = NSArray()
    var predicate : NSPredicate = NSPredicate()
    let colomnList: [String] = ["ITEM CODE", "ITEM NAME","QUANTITY","EDIT TEXT","AddTOCard Button"]
    
    //,EDIT TEXT, AddTOCard Button

    var productListTableView : UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setTheNavigationProperty()
        self.designProductListTableView()
        self.getTheProductsList()

        // self.setUpTheSpreadSheetView()
        // Do any additional setup after loading the view.
    }

    func getTheProductsList(){
        
        let productEn = NSEntityDescription.entityForName("CX_Products", inManagedObjectContext: NSManagedObjectContext.MR_contextForCurrentThread())
        let fetchRequest = CX_Products.MR_requestAllSortedBy("name", ascending: true)
        fetchRequest.predicate = self.predicate
        fetchRequest.entity = productEn
        self.productsList =   CX_Products.MR_executeFetchRequest(fetchRequest)

        self.productListTableView.reloadData()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func designProductListTableView(){
        self.productListTableView = UITableView.init(frame: self.view.frame)
        self.productListTableView.dataSource = self
        self.productListTableView.delegate = self
        self.productListTableView.backgroundColor = UIColor.whiteColor()
        //self.productListTableView.registerClass(CXDetailTableViewCell.self, forCellReuseIdentifier: "DetailCell")
        self.productListTableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "DetailCell")
        self.productListTableView.registerClass(ProductHeaderCell.self, forCellReuseIdentifier: "HeaderCell")

        self.view.addSubview(self.productListTableView)
        
    }
    
    func setTheNavigationProperty(){
        super.viewDidLoad()
        self.title = "WELOCOME TO NV AGENCIES"
        //self.designHeaderView()
        self.navigationController?.navigationBarHidden = false
        navigationController!.navigationBar.tintColor = UIColor.whiteColor()
        navigationController!.navigationBar.barTintColor = UIColor.redColor()
        navigationController!.navigationBar.titleTextAttributes =
            [NSForegroundColorAttributeName: UIColor.whiteColor()]
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


extension ProductListCntl : UITableViewDelegate,UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.productsList.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let identifier = "DetailCell"
        
        var cell: UITableViewCell! = tableView.dequeueReusableCellWithIdentifier(identifier) as? CXDetailTableViewCell
        if cell == nil {
            cell = UITableViewCell(style: UITableViewCellStyle.Value1, reuseIdentifier: identifier)
        }
        
        let proListData : CX_Products = self.productsList[indexPath.row] as! CX_Products
        
        cell.contentView.addSubview(self.createLabel(CXConstant.itemCodeLblFrame, titleString: proListData.itemCode!))
        cell.contentView.addSubview(self.createLabel(CXConstant.itemNameLblFrame, titleString: proListData.name!))
        cell.contentView.addSubview(self.createLabel(CXConstant.itemQuantityFrame, titleString: "Each"))
        cell.contentView.addSubview(self.createLabel(CXConstant.itemtextFrame, titleString: ""))
        cell.contentView.addSubview(self.createAddtoCartButton(CXConstant.addtoCartFrame, title: "Add To Cart",indexPtah: indexPath))
        
        return cell;
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 70;
    }
    
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let  headerCell = tableView.dequeueReusableCellWithIdentifier("HeaderCell") as! ProductHeaderCell
        headerCell.backgroundColor = UIColor.whiteColor()
        return headerCell
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 51
    }
    
    
    func createLabel(frame:CGRect ,titleString:NSString) -> UILabel {
        
        let textFrame =  CGRectMake(frame.origin.x, frame.origin.y+5, frame.size.width, frame.size.height+20)
        let  textLabel: UILabel = UILabel(frame: textFrame)
        textLabel.font = UIFont.systemFontOfSize(UIFont.smallSystemFontSize())
        textLabel.textAlignment = .Center
        //textLabel.font = UIFont(name:"Roboto-Regular",size:8)
        textLabel.font = UIFont.boldSystemFontOfSize(13.0)
        textLabel.text = titleString as String
        textLabel.textColor = UIColor.blackColor()
        textLabel.numberOfLines = 0
        return textLabel
    }
    
    func createAddtoCartButton(frame:CGRect,title : NSString ,indexPtah : NSIndexPath) -> UIButton {
        
        let button   = UIButton.init() as UIButton
        button.frame = CGRectMake(frame.origin.x, 10, frame.size.width-5, 40)
        button.backgroundColor = CXConstant.collectionCellBgColor
        button.setTitle(title as String, forState: UIControlState.Normal)
        button.tag = indexPtah.row
       // button.titleLabel?.font =  UIFont(name:"Roboto-Regular",size:5)
        button.titleLabel?.font = UIFont.boldSystemFontOfSize(8.0)
        button.addTarget(self, action: #selector(ProductListCntl.addToCartButton(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        button.layer.cornerRadius = 8.0
        button.layer.borderWidth = 2.0
        button.layer.borderColor = UIColor.whiteColor().CGColor
        button.showsTouchWhenHighlighted = true
        return button
    }
    

    func addToCartButton (button : UIButton!){
        
        
    }
    
    
   

    //MARK: Cell Detail Data
    
}

extension UILabel{
    dynamic var defaultFont: UIFont? {
        get { return self.font }
        set { self.font = newValue }
    }
}

