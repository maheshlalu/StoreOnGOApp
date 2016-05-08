//
//  ProductHomeCntl.swift
//  StoreOnGoApp
//
//  Created by Rama kuppa on 08/05/16.
//  Copyright © 2016 CX. All rights reserved.
//

import UIKit

class ProductHomeCntl: UIViewController {

    var  _pageControl : ADPageControl = ADPageControl()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.whiteColor()
        self.setTheNavigationProperty()
       // self.setUpPageView()
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
    
    
    func setUpPageView(){
        
        let page1 : ADPageModel = ADPageModel()
        page1.strPageTitle = "PRODUCTS LIST"
        page1.viewController = ProductsCnt.init()
        page1.iPageNumber = 0
        
        let page2 : ADPageModel = ADPageModel()
        page2.strPageTitle = "MISCELLANEOUS"
        page2.viewController = ProductsCnt.init()
        page2.iPageNumber = 1

        self._pageControl.delegateADPageControl = self
        
        _pageControl.arrPageModel = [page1,page2];
        
        _pageControl.iFirstVisiblePageNumber =  1;
        _pageControl.iTitleViewHeight =         40;
        _pageControl.iPageIndicatorHeight =     4;
       // _pageControl.fontTitleTabText =         [UIFont fontWithName:@"Helvetica" size:16];
        
        _pageControl.bEnablePagesEndBounceEffect =  false;
        _pageControl.bEnableTitlesEndBounceEffect = false;
        
        _pageControl.colorTabText =              UIColor.whiteColor()
        _pageControl.colorTitleBarBackground =       UIColor.purpleColor()
        _pageControl.colorPageIndicator =               UIColor.whiteColor()
        _pageControl.colorPageOverscrollBackground =    UIColor.lightGrayColor()
        _pageControl.bShowMoreTabAvailableIndicator =   false;
        
        self._pageControl.view.frame = CGRectMake(0, 100, CXConstant.screenSize.width, CXConstant.screenSize.height-CXConstant.headerViewHeigh)
        self.view.addSubview(_pageControl.view)
        _pageControl.view.translatesAutoresizingMaskIntoConstraints = false;
        
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

extension ProductHomeCntl:ADPageControlDelegate {
    
    func adPageControlGetViewControllerForPageModel(pageModel: ADPageModel!) -> UIViewController! {
        
        var page : UIViewController = UIViewController.init()
        return page
    }
}
