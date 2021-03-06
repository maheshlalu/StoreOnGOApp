//
//  StickersViewCnt.swift
//  StoreOnGoApp
//
//  Created by Rama kuppa on 06/07/16.
//  Copyright © 2016 CX. All rights reserved.
//

import UIKit
let screenSize = UIScreen.mainScreen().bounds.size

class StickersViewCnt: UIViewController {
    var stickersCollectionView: UICollectionView!
    var stickersList : NSArray = NSArray()
    var heder: UIView!
    var presentWindow : UIWindow?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.designHeaderView()
        self.setupCollectionView()
        //Get The Stickers
        self.view.backgroundColor = CXConstant.homeBackGroundColr
        let predicate:NSPredicate = NSPredicate(format: "masterCategory = %@", "Sticker(1440)")
       self.getStickers(predicate)
        presentWindow = UIApplication.sharedApplication().keyWindow
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func designHeaderView (){
        if NSUserDefaults.standardUserDefaults().valueForKey("USER_ID") != nil{
            heder =  CXHeaderView.init(frame: CGRectMake(0, 0, CXConstant.screenSize.width, CXConstant.headerViewHeigh), andTitle: "Stickers", andDelegate: self, backButtonVisible: true, cartBtnVisible: true,profileBtnVisible: true, isForgot: false ,isLogout:true)
        }else{
            heder = CXHeaderView.init(frame: CGRectMake(0, 0, CXConstant.screenSize.width, CXConstant.headerViewHeigh), andTitle: "Stickers", andDelegate: self, backButtonVisible: true, cartBtnVisible: true,profileBtnVisible: true, isForgot: false,isLogout:false)
        }
        self.view.addSubview(heder)
        
    }
    func getStickers(predicate:NSPredicate){
            //let fetchRequest = NSFetchRequest(entityName: "TABLE_PRODUCT_SUB_CATEGORIES")
            let productEn = NSEntityDescription.entityForName("TABLE_PRODUCT_SUB_CATEGORIES", inManagedObjectContext: NSManagedObjectContext.MR_contextForCurrentThread())
            let fetchRequest = TABLE_PRODUCT_SUB_CATEGORIES.MR_requestAllSortedBy("name", ascending: true)
            fetchRequest.predicate = predicate
            fetchRequest.entity = productEn
            print("stickers %d",TABLE_PRODUCT_SUB_CATEGORIES.MR_executeFetchRequest(fetchRequest).count)
            self.stickersList =   TABLE_PRODUCT_SUB_CATEGORIES.MR_executeFetchRequest(fetchRequest)
          self.stickersCollectionView.reloadData()
        
      /*  for (index, element) in self.stickersList.enumerate() {
            let cart : TABLE_PRODUCT_SUB_CATEGORIES = element as! TABLE_PRODUCT_SUB_CATEGORIES
            print("product name %@",cart.name)
            print("product name %@",cart.icon_URL)
        }*/
           // self.stickersList.reloadData()
            
    }

        func setupCollectionView (){
            let layout = UICollectionViewFlowLayout()
            layout.sectionInset = UIEdgeInsets(top: 5, left: 5, bottom: 50, right: 5)
           // layout.itemSize = CXConstant.DetailCollectionCellSize
            layout.minimumInteritemSpacing = 2
            layout.minimumLineSpacing = 6
            self.stickersCollectionView = UICollectionView(frame: CGRectMake(0, CXConstant.headerViewHeigh,screenSize.width, screenSize.height-CXConstant.headerViewHeigh), collectionViewLayout: layout)
            self.stickersCollectionView.showsHorizontalScrollIndicator = false
            layout.scrollDirection = UICollectionViewScrollDirection.Vertical
           // self.stickersCollectionView.registerClass(CX_StickerCell.self, forCellWithReuseIdentifier: "CX_StickerCell")
            self.stickersCollectionView.registerNib(UINib(nibName: "CX_StickerCell", bundle: nil), forCellWithReuseIdentifier: "CX_StickerCell")
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

    func alertWithMessage(alertMessage:String){
        
        let alert = UIAlertController(title: "NV Agencies", message:alertMessage, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "Okay", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
        
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

extension StickersViewCnt:UICollectionViewDelegate,UICollectionViewDataSource {
    
    func collectionView(collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        // let prodCategory:CX_Product_Category = self.mallProductCategories[collectionView.tag] as! CX_Product_Category
        // let products:NSArray = self.getProducts(prodCategory)
        return stickersList.count;
    }
    
    func collectionView(collectionView: UICollectionView,
                        cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let identifier = "CX_StickerCell"
        let cell: CX_StickerCell! = collectionView.dequeueReusableCellWithReuseIdentifier(identifier, forIndexPath: indexPath) as?CX_StickerCell
        if cell == nil {
            collectionView.registerNib(UINib(nibName: "CX_StickerCell", bundle: nil), forCellWithReuseIdentifier: identifier)
        }
        let proCat : TABLE_PRODUCT_SUB_CATEGORIES = self.stickersList[indexPath.row] as! TABLE_PRODUCT_SUB_CATEGORIES
        cell.productNameLbl?.text = proCat.name
        cell.product_imageView.sd_setImageWithURL(NSURL(string: proCat.icon_URL!), placeholderImage: nil)
        return cell
   }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        //print("Collection view at row \(collectionView.tag) selected index path \(indexPath) indexPath Row\(indexPath.row)")
        
        let proCat : TABLE_PRODUCT_SUB_CATEGORIES = self.stickersList[indexPath.row] as! TABLE_PRODUCT_SUB_CATEGORIES
        let pID = proCat.id
        let appendStr = proCat.name!+"("+pID!+")"
        print("append string \(appendStr)")
        let productListVc = StickerDetails.init()
        productListVc.predicate = NSPredicate(format: "subCatNameID = %@",appendStr )
        productListVc.predicateString = appendStr
        productListVc.headerTitle = proCat.name!
        self.navigationController?.pushViewController(productListVc, animated: false)
        
    }
    func collectionView(collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                               sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        return CGSize(width: screenSize.width/3.1555, height: screenSize.width/3)
        
    }
    
 
}

extension StickersViewCnt : HeaderViewDelegate {
    
    func backButtonAction (){
        self.navigationController?.popViewControllerAnimated(true)
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
        designHeaderView()
        alertWithMessage("User Logout Successfully!")
        
    }
    
}
