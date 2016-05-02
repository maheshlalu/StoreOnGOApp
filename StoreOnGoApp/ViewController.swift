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
    var coverPageImagesList: NSMutableArray!
    var headerview: HeaderView!
    var searchBar: SearchBar!


    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.whiteColor()
        self.navigationController?.navigationBarHidden = true
        self.designHeaderView()
        CX_AppData.sharedInstance.dataDelegate = self
        CX_AppData.sharedInstance.getStoresData()
        self.setupCollectionView()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBarHidden = true
    }

    
    //MARK : HeaderView
    func designHeaderView (){
        
        self.headerview = HeaderView.customizeHeaderView(true, headerTitle: "WELOCOME TO NV AGENCIES",backButtonVisible: false)
        self.view.addSubview(self.headerview)
        self.headerview.delegate = self
        self.designSearchBar()
        
    }
    
    //MARK : SearchBar
    func designSearchBar (){
     
        self.searchBar = SearchBar.designSearchBar()
        self.searchBar.delegate = self
        self.view.addSubview(self.searchBar)
    }

    //MARK: Get Stores
    func getStores(){
        let storesData : CX_Stores = CXDBSettings.sharedInstance.getTableData("CX_Stores").lastObject as! CX_Stores
       self.coverPageImagesList = storesData.attachments as? NSMutableArray
          print("data array \(storesData.attachments)")
        self.setupPagenator()
    }
    
    // MARK: - SetUp Paginater
    
   func setupPagenator (){
        
        imagePager.frame = CXConstant.pagerFrame
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
            //   BXProgressHUD.showHUDAddedTo(self.view).hide(afterDelay: 1)
            SMSyncService.sharedInstance.startSyncProcessWithUrl("http://storeongo.com:8081/Services/getMasters?type=stores&mallId=4452") { (responseDict) in
                // print("data array \(responseDict)")
        }
     
    }
    
    
    
    // MARK: - Call Services
    
    
}


extension ViewController:KIImagePagerDelegate,KIImagePagerDataSource {

//    }
    
    func contentModeForImage(image: UInt, inPager pager: KIImagePager!) -> UIViewContentMode {
        
        return .ScaleAspectFill
    }
    
    func arrayWithImages(pager: KIImagePager!) -> [AnyObject]! {
        return self.coverPageImagesList as [AnyObject]
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
       // let fetureProductView = FeatureProductsCnt.init()
       // self.navigationController?.pushViewController(fetureProductView, animated: true)

        let productView = ProductsCnt.init()
        self.navigationController?.pushViewController(productView, animated: true)
        
    }
    
}


extension ViewController:UISearchBarDelegate{
    func searchBarSearchButtonClicked( searchBar: UISearchBar)
    {

    }
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        print("search string \(searchText)")
    }

}

extension ViewController: DetailViewControllerDelegate {
    func didFinishTask(sender: HeaderView) {
        // do stuff like updating the UI
    }
}

extension ViewController :AppDataDelegate {
    
    func completedTheFetchingTheData(sender: CX_AppData) {
         self.getStores()

    }

}
