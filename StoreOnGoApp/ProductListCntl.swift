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
    
    var productListTableView : UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setTheNavigationProperty()
        //self.designProductListTableView()
        self.setUpTheSpreadSheetView()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getTheProductsList(){
        
        
    }
    
    
    func setUpTheSpreadSheetView (){
        
       // let spreadSheet : MMSpreadsheetView = MMSpreadsheetView
        
        let spreadSheetView: MMSpreadsheetView = MMSpreadsheetView(numberOfHeaderRows: 1, numberOfHeaderColumns: 1, frame: CGRectMake(0, 70, CXConstant.screenSize.width, CXConstant.screenSize.height-70))
        spreadSheetView.registerCellClass(ProductNameCell.self, forCellWithReuseIdentifier: "ProductNameCell")
        spreadSheetView.registerCellClass(ProductQuantityCell.self, forCellWithReuseIdentifier: "ProductQuantityCell")
        spreadSheetView.registerCellClass(ProductCartCell.self, forCellWithReuseIdentifier: "ProductCartCell")

        spreadSheetView.dataSource = self
        spreadSheetView.delegate = self
        self.view.addSubview(spreadSheetView)
        
    }
    
    func designProductListTableView(){
        self.productListTableView = UITableView.init(frame: self.view.frame)
        self.productListTableView.dataSource = self
        self.productListTableView.dataSource = self
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
        return 5
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let identifier = "DetailCell"
        
        var cell: UITableViewCell! = tableView.dequeueReusableCellWithIdentifier(identifier) as? CXDetailTableViewCell
        if cell == nil {
            cell = UITableViewCell(style: UITableViewCellStyle.Value1, reuseIdentifier: identifier)
        }
       // cell.setCollectionViewDataSourceDelegate(self, forRow: indexPath.row)
        // cell.collectionViewOffset = storedOffsets[indexPath.row] ?? 0
        
        //cell.headerLbl.text = self.detailItems[indexPath.row]
        
        return cell;
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 30;
    }
    
     func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let  headerCell = tableView.dequeueReusableCellWithIdentifier("HeaderCell") as! ProductHeaderCell
        headerCell.backgroundColor = UIColor.cyanColor()
        return headerCell
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }

    
}

extension ProductListCntl :MMSpreadsheetViewDataSource,MMSpreadsheetViewDelegate {
    
    func spreadsheetView(spreadsheetView: MMSpreadsheetView!, sizeForItemAtIndexPath indexPath: NSIndexPath!) -> CGSize {
     
        return CGSizeMake(100, 50)
    }
    
    func numberOfRowsInSpreadsheetView(spreadsheetView: MMSpreadsheetView!) -> Int {
        
        return 25
    }
    
    func numberOfColumnsInSpreadsheetView(spreadsheetView: MMSpreadsheetView!) -> Int {
        
        return 5
    }
    
    func spreadsheetView(spreadsheetView: MMSpreadsheetView!, cellForItemAtIndexPath indexPath: NSIndexPath!) -> UICollectionViewCell! {
        
        let identifier = "ProductNameCell"
        let cell: ProductNameCell! = spreadsheetView.dequeueReusableCellWithReuseIdentifier(identifier, forIndexPath: indexPath) as?ProductNameCell
        if indexPath.mmSpreadsheetRow() == 0 && indexPath.mmSpreadsheetColumn() == 0 {
            

           let  textLabel: UILabel = UILabel(frame:CGRect(x: 0, y: 0, width: 100, height: 50) )
            textLabel.font = UIFont.systemFontOfSize(UIFont.smallSystemFontSize())
            textLabel.textAlignment = .Center
            textLabel.font = UIFont.boldSystemFontOfSize(10)
            textLabel.textColor = UIColor.whiteColor()
            textLabel.backgroundColor = CXConstant.collectionCellBgColor
            cell.contentView.addSubview(textLabel)
            textLabel.text = "Hello111"

        }
      
        //let proCat : TABLE_PRODUCT_SUB_CATEGORIES = self.productCategories[indexPath.row] as! TABLE_PRODUCT_SUB_CATEGORIES
        
        cell.textLabel.text = "Hello"
        return cell
        
    }
  
}

