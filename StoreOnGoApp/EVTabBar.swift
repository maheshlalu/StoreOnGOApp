//
//  EVTabBar.swift
//  Pods
//
//  Created by Eric Vennaro on 2/29/16.
//
//
import UIKit
///Protocol determines the layout of the tab bar
public protocol EVTabBar: class {
    ///UIImage that serves as deliminator between the tab bar and UIViewControllers displayed
    var shadowView: UIImageView { get set }
    ///Array containing UIViewControllers to be displayed
    var subviewControllers: [UIViewController] { get set }
    ///EVPageViewController itself
    var topTabBar: EVPageViewTopTabBar { get set }
    ///UIPageViewController that serves as the base
    var pageController: UIPageViewController { get set }
}

public extension EVTabBar where Self: UIViewController {
    ///Sets up the UI of the page view and tab bar
    public func setupPageView() {
        topTabBar.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(topTabBar)
        pageController.view.translatesAutoresizingMaskIntoConstraints = false
        pageController.view.frame = view.bounds
        shadowView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(shadowView)
        pageController.setViewControllers([subviewControllers[0]], direction: .Forward, animated: false, completion: nil)
        addChildViewController(pageController)
        view.addSubview(pageController.view)
        pageController.didMoveToParentViewController(self)
        pageController.view.addSubview(shadowView)
    }
    ///Sets constraints for the view
    public func setupConstraints() {
        let views: [String:AnyObject] = ["menuBar" : topTabBar, "pageView" : pageController.view, "shadow" : shadowView]
        view.addConstraints(
            NSLayoutConstraint.constraintsWithVisualFormat("|[menuBar]|", options: [], metrics: nil, views: views))
        view.addConstraints(
            NSLayoutConstraint.constraintsWithVisualFormat("V:|[menuBar(==40)][pageView]|", options: [], metrics: nil, views: views))
        view.addConstraints(
            NSLayoutConstraint.constraintsWithVisualFormat("|[pageView]|", options: [], metrics: nil, views: views))
        
        pageController.view.addConstraints(
            NSLayoutConstraint.constraintsWithVisualFormat("|[shadow]|", options: [], metrics: nil, views: views))
        pageController.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[shadow(7)]", options: [], metrics: nil, views: ["shadow" : shadowView]))
    }
}

