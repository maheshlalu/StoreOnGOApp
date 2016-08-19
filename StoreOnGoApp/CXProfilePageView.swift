//
//  CXProfilePageView.swift
//  Silly Monks
//
//  Created by Mahesh Y on 7/29/16.
//  Copyright © 2016 Sarath. All rights reserved.
//

import UIKit


class CXProfilePageView: UIViewController,EVTabBar{

    var pageController = UIPageViewController(transitionStyle: .Scroll, navigationOrientation: .Horizontal, options: nil)
    var topTabBar: EVPageViewTopTabBar = EVPageViewTopTabBar()
    var subviewControllers: [UIViewController] = []
    var shadowView = UIImageView(image: UIImage(imageLiteral: "filter-background-image"))
    var heder: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupEVTabBar()
        setupPageView()
        setupConstraints()
        self.title = "Profile"
        self.view.backgroundColor = UIColor.whiteColor()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func backAction() {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    private func setupEVTabBar() {
        topTabBar.frame = CGRectMake(0, CXConstant.headerViewHeigh+20, self.view.frame.size.width, (self.view.frame.size.height - CXConstant.headerViewHeigh))
        topTabBar.fontColors = (selectedColor: UIColor.darkGrayColor(), unselectedColor: UIColor.lightGrayColor())
        topTabBar.leftButtonText = "MY PROFILE"
        topTabBar.rightButtonText = "ORDERS"
        topTabBar.labelFont = UIFont(name: "Roboto-Bold", size: 14)!
        topTabBar.indicatorViewColor = UIColor.orangeColor()
        topTabBar.backgroundColor = UIColor.whiteColor()
        topTabBar.setupUI()
        topTabBar.delegate = self
        let firstVC = SMProfileViewController(nibName:"SMProfileViewController", bundle: nil)
        let secondVC:CartViewCntl = CartViewCntl.init()
        subviewControllers = [firstVC,secondVC]
    }
    func alertWithMessage(alertMessage:String){
        
        
        let alert = UIAlertController(title: "NV Agencies", message:alertMessage, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "Okay", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
        
    }

}

//MARK: PageViewTopTabBarDelegate
extension CXProfilePageView: EVPageViewTopTabBarDelegate {
    func willSelectViewControllerAtIndex(index: Int, direction: UIPageViewControllerNavigationDirection) {
        pageController.setViewControllers([self.subviewControllers[index]], direction: direction, animated: true, completion: nil)
    }
}
    

extension CXProfilePageView : HeaderViewDelegate {
    func backButtonAction (){
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    func presentViewController(popUpView: CAPopUpViewController!) {
        self.presentViewController(popUpView, animated: true) {
            
        }
    }
    
    func cartButtonAction(){
        
    }
    func navigationProfileandLogout(isProfile: Bool) {
        
    }
    
    func navigateToProfilepage() {
        let profile : CXProfilePageView = CXProfilePageView.init()
        self.navigationController?.pushViewController(profile, animated: false)
    }
    
    func userLogout() {

    }
    
}
