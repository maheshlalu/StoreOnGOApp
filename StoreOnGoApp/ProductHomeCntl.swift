//
//  ProductHomeCntl.swift
//  StoreOnGoApp
//
//  Created by Rama kuppa on 08/05/16.
//  Copyright © 2016 CX. All rights reserved.
//

import UIKit

class ProductHomeCntl: UIViewController {
    var segmentedControl4 : HMSegmentedControl = HMSegmentedControl()
    var searchBar: SearchBar!
    var productCollectionView: UICollectionView!
    var productCategories: NSArray!
    var isProductCategory : Bool = Bool()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.whiteColor()
        self.setTheNavigationProperty()
        self.setupPager()
        self.designSearchBar()
        self.setupCollectionView()
        let predicate:NSPredicate = NSPredicate(format: "masterCategory = %@", "Products List(129121)")
        isProductCategory = true
        self.getProductSubCategory(predicate)
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
    
    
    func setupPager () {
        
        self.segmentedControl4 = HMSegmentedControl(frame: CGRectMake(0, 60, CXConstant.screenSize.width, 50))
        self.segmentedControl4.sectionTitles = ["PRODUCTS LIST", "MISCELLANEOUS"]
        self.segmentedControl4.selectedSegmentIndex = 0
        self.segmentedControl4.backgroundColor =  UIColor.whiteColor()
        self.segmentedControl4.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.blackColor()]
        self.segmentedControl4.selectedTitleTextAttributes = [NSForegroundColorAttributeName: UIColor(red: 0.1, green: 0.1, blue: 0.1, alpha: 1)]
        self.segmentedControl4.selectionIndicatorColor = UIColor.redColor()
        self.segmentedControl4.selectionStyle = HMSegmentedControlSelectionStyleBox
        self.segmentedControl4.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationUp
        self.segmentedControl4.tag = 3
        segmentedControl4.addTarget(self, action: #selector(ProductHomeCntl.segmentedControlChangedValue(_:)), forControlEvents: .ValueChanged)
        self.view.addSubview(self.segmentedControl4)
        
        //Miscellaneous(135918)
    }
    
    //MARK : SearchBar
    func designSearchBar (){
        
        self.searchBar = SearchBar.designSearchBar()
        self.searchBar.delegate = self
        self.searchBar.placeholder = "Search Products Categories"
        self.view.addSubview(self.searchBar)
    }
    
    
    func setupCollectionView (){
        
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 20, left: 10, bottom: 200, right: 10)
        layout.itemSize = CXConstant.ProductCollectionCellSize
        //self.view.frame
        self.productCollectionView = UICollectionView(frame:CGRectMake(0,CXConstant.searchBarFrame.origin.y+CXConstant.searchBarFrame.size.height, CXConstant.screenSize.width, CXConstant.screenSize.height), collectionViewLayout: layout)
        self.productCollectionView.showsHorizontalScrollIndicator = false
        self.productCollectionView.delegate = self
        self.productCollectionView.dataSource = self
        layout.scrollDirection = UICollectionViewScrollDirection.Vertical
        self.productCollectionView.registerClass(ProductCollectionCell.self, forCellWithReuseIdentifier: "ProductCollectionCell")
        self.productCollectionView.backgroundColor = UIColor.clearColor()
        self.view.addSubview(self.productCollectionView)
    }
    
    
    func getProductSubCategory (predicate:NSPredicate){
        //let fetchRequest = NSFetchRequest(entityName: "TABLE_PRODUCT_SUB_CATEGORIES")
        
        let productEn = NSEntityDescription.entityForName("TABLE_PRODUCT_SUB_CATEGORIES", inManagedObjectContext: NSManagedObjectContext.MR_contextForCurrentThread())
        let fetchRequest = TABLE_PRODUCT_SUB_CATEGORIES.MR_requestAllSortedBy("name", ascending: true)
        fetchRequest.predicate = predicate
        fetchRequest.entity = productEn
        self.productCategories =   TABLE_PRODUCT_SUB_CATEGORIES.MR_executeFetchRequest(fetchRequest)
        self.productCollectionView.reloadData()
        
        
    }

    
    func segmentedControlChangedValue(segmentedControl: HMSegmentedControl) {
        NSLog("Selected index %ld (via UIControlEventValueChanged)", Int(segmentedControl.selectedSegmentIndex))
        let index = Int(segmentedControl.selectedSegmentIndex)
        self.refreshSearchBar()
        switch index {
        case 0  :
            let predicate:NSPredicate = NSPredicate(format: "masterCategory = %@", "Products List(129121)")
            self.getProductSubCategory(predicate)
            isProductCategory = true
            break
        case 1 :
            let predicate:NSPredicate = NSPredicate(format: "masterCategory = %@", "Miscellaneous(135918)")
            self.getProductSubCategory(predicate)
            isProductCategory = false
            break
            
        default :
            break
        }
        
        
    }
    
    func uisegmentedControlChangedValue(segmentedControl: UISegmentedControl) {
       // NSLog("Selected index %ld", Int(segmentedControl.selectedSegmentIndex))
    }
}

extension ProductHomeCntl:UISearchBarDelegate{
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
        
        if isProductCategory {
            let predicate:NSPredicate = NSPredicate(format: "masterCategory = %@", "Products List(129121)")
            self.getProductSubCategory(predicate)
        }else{
            let predicate:NSPredicate = NSPredicate(format: "masterCategory = %@", "Miscellaneous(135918)")
            self.getProductSubCategory(predicate)
        }
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
        
    }
    
    
}


extension ProductHomeCntl:UICollectionViewDelegate,UICollectionViewDataSource {
    
    func collectionView(collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        // let prodCategory:CX_Product_Category = self.mallProductCategories[collectionView.tag] as! CX_Product_Category
        // let products:NSArray = self.getProducts(prodCategory)
        
        return self.productCategories.count;
    }
    
    func collectionView(collectionView: UICollectionView,
                        cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let identifier = "ProductCollectionCell"
        let cell: ProductCollectionCell! = collectionView.dequeueReusableCellWithReuseIdentifier(identifier, forIndexPath: indexPath) as?ProductCollectionCell
        if cell == nil {
            collectionView.registerNib(UINib(nibName: "ProductCollectionCell", bundle: nil), forCellWithReuseIdentifier: identifier)
        }
        
        let proCat : TABLE_PRODUCT_SUB_CATEGORIES = self.productCategories[indexPath.row] as! TABLE_PRODUCT_SUB_CATEGORIES
        
        cell.textLabel.text = proCat.name
        
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        print("Collection view at row \(collectionView.tag) selected index path \(indexPath) indexPath Row\(indexPath.row)")
        
        let index = indexPath.row
        
        //select *from ZCX_PRODUCTS where ZSUBCATNAMEID = 'FORK GUIDE BOLT(130603)'
        
        
    }
    
    
    
}



