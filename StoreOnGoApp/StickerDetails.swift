//
//  StickerDetails.swift
//  StoreOnGoApp
//
//  Created by Rama kuppa on 09/07/16.
//  Copyright © 2016 CX. All rights reserved.
//

import UIKit

class StickerDetails: UIViewController {
    var stickersCollectionView: UICollectionView!
    var stickersList : NSArray = NSArray()
    var predicate : NSPredicate = NSPredicate()
    var headerTitle :  NSString = NSString()
    var searchBar: SearchBar!
    var predicateString : NSString = NSString()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.designHeaderView()
        self.designSearchBar()
        self.setupCollectionView()
        self.getTheProductsList()
        self.view.backgroundColor = CXConstant.homeBackGroundColr

        // Do any additional setup after loading the view.
    }

    func designHeaderView (){
        let heder: UIView =  CXHeaderView.init(frame: CGRectMake(0, 0, CXConstant.screenSize.width, CXConstant.headerViewHeigh), andTitle: "Stickers", andDelegate: self, backButtonVisible: true, cartBtnVisible: true)
        self.view.addSubview(heder)
        
    }
    
    //MARK : SearchBar
    func designSearchBar (){
        self.searchBar = SearchBar.designSearchBar()
        self.searchBar.frame.origin.y =  CXConstant.headerViewHeigh
        // CXConstant.searchBarFrame
        //  self.searchBar.frame = CGRectMake(0, CXConstant.headerViewHeigh, self.searchBar.size.width,  self.searchBar.size.hieght)
        self.searchBar.delegate = self
        self.searchBar.placeholder = "Search Stickers"
        self.view.addSubview(self.searchBar)
    }
    
    
    func setupCollectionView (){
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 20, left: 10, bottom: 50, right: 10)
        layout.itemSize = CXConstant.DetailCollectionCellSize
        self.stickersCollectionView = UICollectionView(frame: CGRectMake(0, CXConstant.headerViewHeigh+self.searchBar.frame.size.height,screenSize.width, screenSize.height-CXConstant.headerViewHeigh), collectionViewLayout: layout)
        self.stickersCollectionView.showsHorizontalScrollIndicator = false
        layout.scrollDirection = UICollectionViewScrollDirection.Vertical
        // self.stickersCollectionView.registerClass(CX_StickerCell.self, forCellWithReuseIdentifier: "CX_StickerCell")
        self.stickersCollectionView.registerNib(UINib(nibName: "StickerDetailCell", bundle: nil), forCellWithReuseIdentifier: "StickerDetailCell")
        self.stickersCollectionView.backgroundColor = UIColor.clearColor()
        self.view.addSubview(self.stickersCollectionView)
        self.stickersCollectionView.delegate = self
        self.setCollectionViewDataSourceDelegate(self, forRow: 0)
    }
    
    func setCollectionViewDataSourceDelegate<D: protocol<UICollectionViewDataSource, UICollectionViewDelegate>>(dataSourceDelegate: D, forRow row: Int) {
        self.stickersCollectionView.delegate = dataSourceDelegate
        self.stickersCollectionView.dataSource = dataSourceDelegate
        self.stickersCollectionView.reloadData()
    }
    
    func getTheProductsList(){
        
        let productEn = NSEntityDescription.entityForName("CX_Products", inManagedObjectContext: NSManagedObjectContext.MR_contextForCurrentThread())
        let fetchRequest = CX_Products.MR_requestAllSortedBy("name", ascending: true)
        fetchRequest.predicate = self.predicate
        fetchRequest.entity = productEn
        self.stickersList =   CX_Products.MR_executeFetchRequest(fetchRequest)
        
        self.stickersCollectionView.reloadData()
        
    }
    
    override func didReceiveMemoryWarning() {
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

}

extension StickerDetails:UICollectionViewDelegate,UICollectionViewDataSource {
    
    func collectionView(collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        // let prodCategory:CX_Product_Category = self.mallProductCategories[collectionView.tag] as! CX_Product_Category
        // let products:NSArray = self.getProducts(prodCategory)
        return stickersList.count;
    }
    
    func collectionView(collectionView: UICollectionView,
                        cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let identifier = "StickerDetailCell"
        let cell: StickerDetailCell! = collectionView.dequeueReusableCellWithReuseIdentifier(identifier, forIndexPath: indexPath) as?StickerDetailCell
        if cell == nil {
            collectionView.registerNib(UINib(nibName: "StickerDetailCell", bundle: nil), forCellWithReuseIdentifier: identifier)
        }
        let proListData : CX_Products = self.stickersList[indexPath.row] as! CX_Products
        cell.itemNameLbl.text = proListData.name
        cell.itemCodeLbl.text = proListData.itemCode
        cell.addToCartBtn.tag = indexPath.row+1
        cell.quantityTxt.delegate = self
        cell.quantityTxt.tag = indexPath.row+1
        cell.addToCartBtn.selected = CXDBSettings.sharedInstance.isAddToCart(proListData.pID!).isAdded
        cell.addToCartBtn.backgroundColor = CXDBSettings.sharedInstance.isAddToCart(proListData.pID!).isAdded ? CXConstant.checkOutBtnColor: UIColor.whiteColor()

        cell.quantityTxt.text = CXDBSettings.sharedInstance.isAddToCart(proListData.pID!).totalCount as String
        cell.addToCartBtn.addTarget(self, action: #selector(StickerDetails.addToCartButton(_:)), forControlEvents: UIControlEvents.TouchUpInside)

       /* let proCat : TABLE_PRODUCT_SUB_CATEGORIES = self.stickersList[indexPath.row] as! TABLE_PRODUCT_SUB_CATEGORIES
        cell.productNameLbl?.text = proCat.name
        cell.product_imageView.sd_setImageWithURL(NSURL(string: proCat.icon_URL!), placeholderImage: nil)*/
        //
        

        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                               sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSize(width: 140, height: 160)
        
    }
    
    func addToCartButton (button : UIButton!){
        let indexPath = NSIndexPath(forRow: button.tag-1, inSection: 0)
        if(!button.selected){
        let cell = self.stickersCollectionView.cellForItemAtIndexPath(indexPath)
        let textField : UITextField = cell?.contentView.viewWithTag(button.tag) as! UITextField
        print("button tag %d\(textField.text)")
        if (!((textField.text?.isEmpty)!)) {
            let proListData : CX_Products = self.stickersList[button.tag-1] as! CX_Products
            CXDBSettings.sharedInstance.addToCart(proListData, quantityNumber: textField.text!, completionHandler: { (added) in
                self.stickersCollectionView.reloadItemsAtIndexPaths([indexPath])
            })
        }
        textField.resignFirstResponder();
        }else{
            let proListData : CX_Products = self.stickersList[button.tag-1] as! CX_Products
            CXDBSettings.sharedInstance.deleteCartItem(proListData.pID!)
            self.stickersCollectionView.reloadItemsAtIndexPaths([indexPath])

        }
    }
    
}

extension StickerDetails : HeaderViewDelegate {
    
    func backButtonAction (){
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    func cartButtonAction(){
        let cartView : CartViewCntl = CartViewCntl.init()
        self.navigationController?.pushViewController(cartView, animated: false)
        
    }
    
}

extension StickerDetails:UISearchBarDelegate{
    func searchBarSearchButtonClicked( searchBar: UISearchBar)
    {
        self.searchBar.resignFirstResponder()
        self.doSearch()
    }
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        // print("search string \(searchText)")
        if (self.searchBar.text!.characters.count > 0) {
            self.doSearch()
        } else {
            self.loadDefaultList()
        }
        
    }
    
    func loadDefaultList (){
        self.getTheProductsList()
    }
    
    func refreshSearchBar (){
        self.searchBar.resignFirstResponder()
        // Clear search bar text
        self.searchBar.text = "";
        // Hide the cancel button
        self.searchBar.showsCancelButton = false;
    }
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        self.refreshSearchBar()
        // Do a default fetch of the beers
        self.loadDefaultList()
    }
    
    func searchBarTextDidBeginEditing(searchBar: UISearchBar) {
        self.searchBar.showsCancelButton = true;
    }
    
    func doSearch () {
        let productEn = NSEntityDescription.entityForName("CX_Products", inManagedObjectContext: NSManagedObjectContext.MR_contextForCurrentThread())
        let fetchRequest = CX_Products.MR_requestAllSortedBy("name", ascending: true)
        fetchRequest.predicate = NSPredicate(format: "subCatNameID = %@ AND name contains[c] %@", self.predicateString,self.searchBar.text!)
        fetchRequest.entity = productEn
        self.stickersList =   CX_Products.MR_executeFetchRequest(fetchRequest)
       /* NSString *modelName = @"honda";
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"model == %@", modelName];
        NSArray *filteredArray = [results filteredArrayUsingPredicate:predicate];*/
        self.stickersCollectionView.reloadData()
    }
    
}

extension StickerDetails : UITextFieldDelegate {
    
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
        let aSet = NSCharacterSet(charactersInString:"0123456789").invertedSet
        let compSepByCharInSet = string.componentsSeparatedByCharactersInSet(aSet)
        let numberFiltered = compSepByCharInSet.joinWithSeparator("")
        return string == numberFiltered    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        if ((textField.text?.isEmpty) != nil) {
        }
        
        
        print("button tag %d\(textField.tag)")
        print("TextField should return method called")
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



