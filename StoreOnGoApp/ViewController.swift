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
    
    var imagePager : KIImagePager = KIImagePager()
    var homeCollectionView: UICollectionView!
    let homeList: [String] = ["Products", "Feature Products","Offers","About Us"]

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.whiteColor()
        self.navigationController?.navigationBarHidden = true
        self.callsServices()
        self.setupPagenator()
        self.setupCollectionView()
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - SetUp Paginater
    
   func setupPagenator (){
        
        imagePager.frame = CGRectMake(5, 50, CXConstant.screenSize.width-10, 250)
        imagePager.pageControl.currentPageIndicatorTintColor = UIColor.lightGrayColor()
        imagePager.pageControl.pageIndicatorTintColor = UIColor.blackColor();
        imagePager.slideshowTimeInterval = 2;
        imagePager.slideshowShouldCallScrollToDelegate = true
        imagePager.delegate = self
        imagePager.dataSource = self;
        //imagePager.checkWetherToToggleSlideshowTimer()
        self.view.addSubview(imagePager)
    }
    
    
    //MARK: - Setup CollectionView
    
    func setupCollectionView (){
        
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 20, left: 10, bottom: 10, right: 10)
        layout.itemSize = CXConstant.DetailCollectionCellSize
        self.homeCollectionView = UICollectionView(frame: CXConstant.collectionFram, collectionViewLayout: layout)
        self.homeCollectionView.showsHorizontalScrollIndicator = false
        layout.scrollDirection = UICollectionViewScrollDirection.Vertical
        self.homeCollectionView.registerClass(HomeCollectionViewCell.self, forCellWithReuseIdentifier: "HomeCollectionViewCell")
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
        self.callTheStoreServices()
        return
            //   BXProgressHUD.showHUDAddedTo(self.view).hide(afterDelay: 1)
            SMSyncService.sharedInstance.startSyncProcessWithUrl("http://storeongo.com:8081/Services/getMasters?type=stores&mallId=4452") { (responseDict) in
                // print("data array \(responseDict)")
        }
        
        let reqUrl = CXConstant.PRODUCT_CATEGORY_URL + CXConstant.MallID
        SMSyncService.sharedInstance.startSyncProcessWithUrl(reqUrl) { (responseDict) -> Void in
            print ("Product category response \(responseDict)")
            // CXDBSettings.sharedInstance.saveProductCategoriesInDB(responseDict.valueForKey("jobs")! as! NSArray, catID: self.mall.mid!)
        }
        
        
    }
    
    
    func callTheStoreServices(){
        
        let reqUrl = CXConstant.STORES_URL + CXConstant.MallID
        SMSyncService.sharedInstance.startSyncProcessWithUrl(reqUrl) { (responseDict) -> Void in
           // print ("stores   response   data \(responseDict.valueForKey("jobs")! as! NSArray) ")
             CXDBSettings.sharedInstance.saveStoresInDB(responseDict.valueForKey("jobs")! as! NSArray)
            //userdetails
            //\(responseDict.valueForKey("jobs")! as! NSArray)
            //   var unarchievedName =    NSKeyedUnarchiver.unarchiveObjectWithData(returnedData[i].valueForKey("name") as NSData) as String

        }
        
    }
    
    // MARK: - Call Services
    
    
}


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


extension ViewController:UICollectionViewDelegate,UICollectionViewDataSource {
    
    func collectionView(collectionView: UICollectionView,
        numberOfItemsInSection section: Int) -> Int {
            // let prodCategory:CX_Product_Category = self.mallProductCategories[collectionView.tag] as! CX_Product_Category
            // let products:NSArray = self.getProducts(prodCategory)
            
            return homeList.count;
    }
    
    func collectionView(collectionView: UICollectionView,
        cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
            let identifier = "HomeCollectionViewCell"
            let cell: HomeCollectionViewCell! = collectionView.dequeueReusableCellWithReuseIdentifier(identifier, forIndexPath: indexPath) as?HomeCollectionViewCell
            if cell == nil {
                collectionView.registerNib(UINib(nibName: "HomeCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: identifier)
            }
        cell.backgroundColor = UIColor.redColor()
        cell.titleLabel.text = homeList[indexPath.row]
            return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        print("Collection view at row \(collectionView.tag) selected index path \(indexPath) indexPath Row\(indexPath.row)")
        let productView = ProductsCnt.init()
        self.navigationController?.pushViewController(productView, animated: true)
        
    }
    
    
}