//
//  ViewController.swift
//  StoreOnGo
//
//  Created by Rama kuppa on 15/04/16.
//  Copyright © 2016 Rama kuppa. All rights reserved.
//

import UIKit
//import BXProgressHUD

class ViewController: UIViewController{
    
   // var imagePager : KIImagePager = KIImagePager()
    var homeCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.whiteColor()
        /*productCategory = ProductCategories.createEntity() as! ProductCategories
        productCategory.categoryName = "StoreOnGo"
        productCategory.dummyName = "dummyData"
        
        NSManagedObjectContext.defaultContext().saveToPersistentStoreAndWait()*/
        
        self.callsServices()
        //self.setupPagenator()
        //self.setupCollectionView()
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - SetUp Paginater
    
   /* func setupPagenator (){
        
        imagePager.frame = CGRectMake(5, 50, CXConstant.screenSize.width-10, 250)
        imagePager.pageControl.currentPageIndicatorTintColor = UIColor.lightGrayColor()
        imagePager.pageControl.pageIndicatorTintColor = UIColor.blackColor();
        imagePager.slideshowTimeInterval = 2;
        imagePager.slideshowShouldCallScrollToDelegate = true
        imagePager.delegate = self
        imagePager.dataSource = self;
        //imagePager.checkWetherToToggleSlideshowTimer()
        self.view.addSubview(imagePager)
    }*/
    
    
    //MARK: - Setup CollectionView
    
    func setupCollectionView (){
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CXConstant.DetailCollectionCellSize
        self.homeCollectionView = UICollectionView(frame: CGRectMake(0, 300, CXConstant.screenSize.width, 400), collectionViewLayout: layout)
        self.homeCollectionView.showsHorizontalScrollIndicator = false
        self.homeCollectionView.frame = CXConstant.DetailCollectionViewFrame
        layout.scrollDirection = UICollectionViewScrollDirection.Vertical
        self.homeCollectionView.registerClass(CXDetailCollectionViewCell.self, forCellWithReuseIdentifier: "DetailCollectionViewCell")
        self.homeCollectionView.backgroundColor = UIColor.clearColor()
        self.view.addSubview(self.homeCollectionView)
        self.setCollectionViewDataSourceDelegate(self, forRow: 0)
        
    }
    
    func setCollectionViewDataSourceDelegate<D: protocol<UICollectionViewDataSource, UICollectionViewDelegate>>(dataSourceDelegate: D, forRow row: Int) {
        self.homeCollectionView.delegate = dataSourceDelegate
        self.homeCollectionView.dataSource = dataSourceDelegate
        self.homeCollectionView.reloadData()
    }
    
    
    
    // MARK: - Call Services
    
    func callsServices () {
        
        //   BXProgressHUD.showHUDAddedTo(self.view).hide(afterDelay: 1)
        SMSyncService.sharedInstance.startSyncProcessWithUrl("http://storeongo.com:8081/Services/getMasters?type=stores&mallId=4452") { (responseDict) in
            // print("data array \(responseDict)")
        }
        
        let reqUrl = CXConstant.PRODUCT_CATEGORY_URL + CXConstant.MallID
        SMSyncService.sharedInstance.startSyncProcessWithUrl(reqUrl) { (responseDict) -> Void in
            print ("Product category response \(responseDict)")
            // CXDBSettings.sharedInstance.saveProductCategoriesInDB(responseDict.valueForKey("jobs")! as! NSArray, catID: self.mall.mid!)
        }
        
        self.callTheStoreServices()
        
    }
    
    
    func callTheStoreServices(){
        
        let reqUrl = CXConstant.STORES_URL + CXConstant.MallID
        SMSyncService.sharedInstance.startSyncProcessWithUrl(reqUrl) { (responseDict) -> Void in
            print ("stores   response   data \(responseDict.valueForKey("userdetails")! as! NSDictionary) ")
            // CXDBSettings.sharedInstance.saveProductCategoriesInDB(responseDict.valueForKey("jobs")! as! NSArray, catID: self.mall.mid!)
            //userdetails
            //\(responseDict.valueForKey("jobs")! as! NSArray)
        }
        
    }
    
    // MARK: - Call Services
    
    
}

/*
extension ViewController:KIImagePagerDelegate,KIImagePagerDataSource {
    
    func arrayWithImages(pager: KIImagePager!) -> [AnyObject]! {
        
        return [
            "https://raw.github.com/kimar/tapebooth/master/Screenshots/Screen1.png",
            "https://raw.github.com/kimar/tapebooth/master/Screenshots/Screen2.png",
            "https://raw.github.com/kimar/tapebooth/master/Screenshots/Screen3.png"
        ];
    }
    
    func contentModeForImage(image: UInt, inPager pager: KIImagePager!) -> UIViewContentMode {
        
        return .ScaleAspectFill
    }
    
}
*/

extension ViewController:UICollectionViewDelegate,UICollectionViewDataSource {
    
    func collectionView(collectionView: UICollectionView,
        numberOfItemsInSection section: Int) -> Int {
            // let prodCategory:CX_Product_Category = self.mallProductCategories[collectionView.tag] as! CX_Product_Category
            // let products:NSArray = self.getProducts(prodCategory)
            
            return 4;
    }
    
    func collectionView(collectionView: UICollectionView,
        cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
            let identifier = "DetailCollectionViewCell"
            let cell: CXDetailCollectionViewCell! = collectionView.dequeueReusableCellWithReuseIdentifier(identifier, forIndexPath: indexPath) as?CXDetailCollectionViewCell
            if cell == nil {
                collectionView.registerNib(UINib(nibName: "CXDetailCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: identifier)
            }
            return cell
    }
}

/*
 
 var homeList:[String] = ["setting", "fetured", "offer","aboutus"]
 
 
 override func viewDidLoad() {
 super.viewDidLoad()
 // Do any additional setup after loading the view, typically from a nib.
 
 //http://randexdev.com/2014/07/uicollectionview/
 
 let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
 layout.sectionInset = UIEdgeInsets(top: 20, left: 10, bottom: 10, right: 10)
 layout.itemSize = CGSize(width: 192, height: 140)
 
 collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
 collectionView.dataSource = self
 collectionView.delegate = self
 collectionView.registerClass(UICollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
 collectionView.backgroundColor = UIColor.whiteColor()
 self.view.addSubview(collectionView)
 }
 
 override func didReceiveMemoryWarning() {
 super.didReceiveMemoryWarning()
 // Dispose of any resources that can be recreated.
 }
 
 func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
 return homeList.count
 }
 
 func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
 let cell = collectionView.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath)
 cell.backgroundColor = UIColor.redColor()
 return cell
 }

 */


