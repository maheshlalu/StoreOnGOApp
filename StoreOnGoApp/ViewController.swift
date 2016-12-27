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
    let homeList: [String] = ["products", "stickers","offers","aboutUs"]
    let homeListTitles: [String] = ["Products", "Stickers","Offers","AboutUs"]

    var coverPageImagesList: NSMutableArray!
    var headerview: HeaderView!
    var searchBar: SearchBar!
    
    var heder: UIView!
    var presentWindow : UIWindow?


    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = CXConstant.homeBackGroundColr
        self.navigationController?.navigationBarHidden = true
        //self.designHeaderView()
        CXDBSettings.sharedInstance.dataDelegate = self
        CX_AppData.sharedInstance.getStoresData()
        //self.getStores()
        presentWindow = UIApplication.sharedApplication().keyWindow

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
        self.designHeaderView()
    }

    
    //MARK : HeaderView
    func designHeaderView (){
        if NSUserDefaults.standardUserDefaults().valueForKey("USER_ID") != nil{
        heder =  CXHeaderView.init(frame: CGRectMake(0, 0, CXConstant.screenSize.width, CXConstant.headerViewHeigh), andTitle: "Home", andDelegate: self, backButtonVisible: false, cartBtnVisible: true,profileBtnVisible: true, isForgot: false ,isLogout:true)
        }else{
        heder = CXHeaderView.init(frame: CGRectMake(0, 0, CXConstant.screenSize.width, CXConstant.headerViewHeigh), andTitle: "Home", andDelegate: self, backButtonVisible: false, cartBtnVisible: true,profileBtnVisible: true, isForgot: false,isLogout:false)
        }
        self.view.addSubview(heder)
        return
      /*  self.headerview = HeaderView.customizeHeaderView(true, headerTitle: "WELOCOME TO NV AGENCIES",backButtonVisible: false)
        self.view.addSubview(self.headerview)
        self.headerview.delegate = self*/
        //self.designSearchBar()
        
    }
    
    //MARK : SearchBar
    func designSearchBar (){
        self.searchBar = SearchBar.designSearchBar()
        self.searchBar.delegate = self
        self.view.addSubview(self.searchBar)
    }

    //MARK: Get Stores
    func getStores(){
        
        dispatch_async(dispatch_get_main_queue(),{
            let fetchRequest = NSFetchRequest(entityName: "CX_Stores")
            if CX_Stores.MR_executeFetchRequest(fetchRequest).count != 0 {
                let storesData : CX_Stores = CXDBSettings.sharedInstance.getTableData("CX_Stores").lastObject as! CX_Stores
                self.coverPageImagesList = storesData.attachments as? NSMutableArray
                //print("data array \(storesData.attachments)")
                self.setupPagenator()
            }

        })

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
        imagePager.checkWetherToToggleSlideshowTimer()
        self.view.addSubview(imagePager)
    }
    
    
    //MARK: - Setup CollectionView
    
    func setupCollectionView (){
        
        let layout = UICollectionViewFlowLayout()
       
        layout.sectionInset = UIEdgeInsets(top: 2, left: 7, bottom: 50, right: 7)
        if (CXConstant.currentDeviceScreen() == IPHONE_6PLUS) {
            layout.sectionInset = UIEdgeInsets(top: 2, left: 8, bottom: 50, right: 8)
        }
        layout.itemSize = CXConstant.DetailCollectionCellSize
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 2.2
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
//     MARK: - Call Services
    
    
}

//MARK: PagerDelegate
extension ViewController:KIImagePagerDelegate,KIImagePagerDataSource {

//    }
    
    func contentModeForImage(image: UInt, inPager pager: KIImagePager!) -> UIViewContentMode {
        
        return .ScaleToFill
    }
    
    func arrayWithImages(pager: KIImagePager!) -> [AnyObject]! {
        return self.coverPageImagesList as [AnyObject]
    }
    
}


extension ViewController:UICollectionViewDelegate,UICollectionViewDataSource {
    
    func collectionView(collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                               sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
//         if(CXConstant.currentDeviceScreen() == IPHONE_6PLUS){
//            return CGSize(width: screenSize.width/2.15552, height: screenSize.width/2)
//        }
        return CGSize(width: screenSize.width/2.15552, height: screenSize.width/2)
        
    }
    
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
       // cell.backgroundColor = UIColor.redColor()
       // cell.titleLabel.text = homeListTitles[indexPath.row]
        cell.iconImageView.image = UIImage(named: homeList[indexPath.row])
        return cell
    }
    
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
       // print("Collection view at row \(collectionView.tag) selected index path \(indexPath) indexPath Row\(indexPath.row)")
        
        let index = indexPath.row
        switch index {
        case 0  :
            let productView = ProductHomeCntl.init()
            self.navigationController?.pushViewController(productView, animated: true)
            break
        case 1 :
            let mapView = StickersViewCnt.init()
            self.navigationController?.pushViewController(mapView, animated: true)
            break
        case 2  :
            presentWindow?.makeToast(message: "Coming Soon!!")

            break
        case 3  :
            //presentWindow?.makeToast(message: "Coming Soon!!")
            
//            let aboutUsView = AboutUsViewCnt.init()
//            self.navigationController?.pushViewController(aboutUsView, animated: true)
            let storyBoard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
            let aboutUs = storyBoard.instantiateViewControllerWithIdentifier("AboutUsViewCnt") as! AboutUsViewCnt
            self.navigationController?.pushViewController(aboutUs, animated: true)
            
            break
        default :
            break
        }
        
    }
    
    
    func alertWithMessage(alertMessage:String){
        
        let alert = UIAlertController(title: "NV Agencies", message:alertMessage, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "Okay", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
        
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
    
    func completedTheFetchingTheData(sender: CXDBSettings) {
        self.getStores()
        LoadingView.hide()
    }

}

extension ViewController : UITextFieldDelegate {
    func showPopupPressed()
    {
        let contentView = UIView(frame: CGRectMake(0, 0, 250, 300))
        self.view.addSubview(contentView)
        
        let textField = AutocompleteField(frame: CGRectMake(50, 120, contentView.frame.size.width, 30), suggestions: ["abraham"])
        textField.placeholder = "Name"

       contentView.addSubview(textField)

    }
 
    
    func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
        print("TextField should begin editing method called")
        textField.becomeFirstResponder()
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
        print("While entering the characters this method gets called")
        return true;
    }

    

}
/*
 let alert = UIAlertController(title: "Alert", message: "Message", preferredStyle: UIAlertControllerStyle.Alert)
 alert.addAction(UIAlertAction(title: "Click", style: UIAlertActionStyle.Default, handler: nil))
 self.presentViewController(alert, animated: true, completion: nil)*/




extension ViewController : HeaderViewDelegate {
    func backButtonAction (){
        
        }
    
    func presentViewController(popUpView: CAPopUpViewController!) {
        self.presentViewController(popUpView, animated: true) { 
            
        }
    }

    func cartButtonAction(){
        let cartView : CartViewCntl = CartViewCntl.init()
        self.navigationController?.pushViewController(cartView, animated: false)
        
    }
    
    func navigationProfileandLogout(isProfile: Bool) {
//        //alertWithMessage("User Logout Successfully!")
//        presentWindow?.makeToast(message: "Coming Soon!!")

        let profile : CXSignInSignUpViewController = CXSignInSignUpViewController.init()
        self.navigationController?.pushViewController(profile, animated: false)
    }
    
    func navigateToProfilepage() {
        if NSUserDefaults.standardUserDefaults().valueForKey("USER_ID") == nil{
            let profile : CXSignInSignUpViewController = CXSignInSignUpViewController.init()
            self.navigationController?.pushViewController(profile, animated: false)
        }else{
            presentWindow?.makeToast(message: "Coming Soon!!")
        }
    }
    
    func userLogout() {
        alertWithMessage("User Logout Successfully!")
        designHeaderView()
//        let viewController: UIViewController = self.navigationController!.viewControllers[1]
//        self.navigationController!.popToViewController(viewController, animated: true)
    }


}
