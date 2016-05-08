//
//  ProductsCnt.swift
//  StoreOnGoApp
//
//  Created by Rama kuppa on 29/04/16.
//  Copyright © 2016 CX. All rights reserved.
//

import UIKit

class ProductsCnt: UIViewController {
    var productCollectionView: UICollectionView!
    var productCategories: NSMutableArray!
    var headerview: HeaderView!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.whiteColor()
        self.setTheNavigationProperty()
        self.setupCollectionView()
       // self.getProducts()
        
        self.getProductSubCategory()
        
        
        // Do any additional setup after loading the view, typically from a nib.
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
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func setupCollectionView (){
        
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 20, left: 10, bottom: 10, right: 10)
        layout.itemSize = CXConstant.ProductCollectionCellSize
        //self.view.frame
        self.productCollectionView = UICollectionView(frame:CGRectMake(0,0, CXConstant.screenSize.width, CXConstant.screenSize.height), collectionViewLayout: layout)
        self.productCollectionView.showsHorizontalScrollIndicator = false
        self.productCollectionView.delegate = self
        self.productCollectionView.dataSource = self
        layout.scrollDirection = UICollectionViewScrollDirection.Vertical
        self.productCollectionView.registerClass(ProductCollectionCell.self, forCellWithReuseIdentifier: "ProductCollectionCell")
        self.productCollectionView.backgroundColor = UIColor.clearColor()
        self.view.addSubview(self.productCollectionView)
    }
    
    func getProducts(){
         let productCatList :NSArray  = (CXDBSettings.sharedInstance.getTableData("CX_Product_Category") as? NSArray)!
        self.productCategories = NSMutableArray(array: productCatList)
        self.productCollectionView.reloadData()

    }
    
    func getProductSubCategory(){
        
        let productCatList :NSArray  = (CXDBSettings.sharedInstance.getTableData("TABLE_PRODUCT_SUB_CATEGORIES") as? NSArray)!
        self.productCategories = NSMutableArray(array: productCatList)
        self.productCollectionView.reloadData()
    }
    
    func designHeaderView (){
        
        self.headerview = HeaderView.customizeHeaderView(true, headerTitle: "",backButtonVisible: true)
        self.view.addSubview(self.headerview)
        
    }
    
    
}

extension ProductsCnt:UICollectionViewDelegate,UICollectionViewDataSource {
    
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
    
    
    
}
