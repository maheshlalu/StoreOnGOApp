//
//  AboutUsViewCnt.swift
//  StoreOnGoApp
//
//  Created by Rama kuppa on 08/05/16.
//  Copyright © 2016 CX. All rights reserved.
//

import UIKit

class AboutUsViewCnt: UIViewController {
    var imagePager : KIImagePager = KIImagePager()
    var coverPageImagesList: NSMutableArray!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.whiteColor()
        self.setTheNavigationProperty()
        self.getStores()
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
        navigationController!.navigationBar.barTintColor = UIColor.grayColor()
        navigationController!.navigationBar.titleTextAttributes =
            [NSForegroundColorAttributeName: UIColor.whiteColor()]
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
        imagePager.backgroundColor = UIColor.redColor()
        self.view.addSubview(imagePager)
    }
    
    //MARK: Get Stores
    func getStores(){
        if CXDBSettings.sharedInstance.getTableData("CX_Stores").count != 0 {
            let storesData : CX_Stores = CXDBSettings.sharedInstance.getTableData("CX_Stores").lastObject as! CX_Stores
            self.coverPageImagesList = storesData.attachments as? NSMutableArray
            print("data array \(storesData.attachments)")
            self.setupPagenator()
        }

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

extension AboutUsViewCnt:KIImagePagerDelegate,KIImagePagerDataSource {
    
    //    }
    
    func contentModeForImage(image: UInt, inPager pager: KIImagePager!) -> UIViewContentMode {
        
        return .ScaleAspectFill
    }
    
    func arrayWithImages(pager: KIImagePager!) -> [AnyObject]! {
        return self.coverPageImagesList as [AnyObject]
    }
    
}

