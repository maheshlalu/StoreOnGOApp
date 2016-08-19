//
//  EVPageViewTopTabBar.swift
//  Pods
//
//  Created by Eric Vennaro on 2/29/16.
//
//
import UIKit
///UIView that represents the tab EVPageViewTopTabBar
public class EVPageViewTopTabBar: UIView {
    private let indicatorView = UIView()
    private let rightButton = UIButton()
    private let leftButton = UIButton()
    private var indicatorXPosition = NSLayoutConstraint()
    private var buttonFontColors: (selectedColor: UIColor, unselectedColor: UIColor)!
    ///Delegate for the tab bar
    public var delegate: EVPageViewTopTabBarDelegate?
    ///Stored property to set the selected and unselected font color
    public var fontColors: (selectedColor: UIColor, unselectedColor: UIColor)? {
        didSet {
            buttonFontColors = fontColors
            rightButton.setTitleColor(fontColors!.unselectedColor, forState: .Normal)
            leftButton.setTitleColor(fontColors!.selectedColor, forState: .Normal)
        }
    }
    ///Stored property sets the text for the right UIButton
    public var rightButtonText: String? {
        didSet {
            rightButton.setTitle(rightButtonText, forState: .Normal)
        }
    }
    ///Stored property sets the text for the left UIButton
    public var leftButtonText: String? {
        didSet {
            leftButton.setTitle(leftButtonText, forState: .Normal)
        }
    }
    ///Stored property sets the font for both UIButton labels
    public var labelFont: UIFont? {
        didSet {
            rightButton.titleLabel?.font = self.labelFont
            leftButton.titleLabel?.font = self.labelFont
        }
    }
    ///Stored property sets the background color of the indicator view
    public var indicatorViewColor: UIColor? {
        didSet {
            indicatorView.backgroundColor = indicatorViewColor
        }
    }
    
    //MARK: - Initialization
    //init with frame
    public init() {
        super.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
    }
    //init with coder
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    //MARK: - Methods
    //Sets UI attributes for the tab bar
    public func setupUI() {
        setupRightButton()
        setupLeftButton()
        setupIndicatorView()
        setupGestureRecognizers()
        
        self.addSubview(leftButton)
        self.addSubview(rightButton)
        self.addSubview(indicatorView)
        
        setConstraints()
    }
    
    func leftButtonWasTouched(sender: UIButton!) {
        animateLeft()
    }
    
    func rightButtonWasTouched(sender: UIButton!) {
        animateRight()
    }
    
    func respondToRightSwipe(gesture: UIGestureRecognizer) {
        animateRight()
    }
    
    func respondToLeftSwipe(gesture: UIGestureRecognizer) {
        animateLeft()
    }
    
    private func setupLeftButton() {
        leftButton.translatesAutoresizingMaskIntoConstraints = false
        leftButton.addTarget(self, action: .leftButtonTapped, forControlEvents: .TouchUpInside)
    }
    
    private func setupRightButton() {
        rightButton.translatesAutoresizingMaskIntoConstraints = false
        rightButton.addTarget(self, action: .rightButtonTapped, forControlEvents: .TouchUpInside)
    }
    
    private func setupIndicatorView() {
        indicatorView.translatesAutoresizingMaskIntoConstraints = false
        indicatorView.layer.cornerRadius = 4
    }
    
    private func setupGestureRecognizers() {
        let rightSwipe = UISwipeGestureRecognizer(target: self, action: .respondToRightSwipe)
        let leftSwipe = UISwipeGestureRecognizer(target: self, action: .respondToLeftSwipe)
        
        rightSwipe.direction = .Right
        leftSwipe.direction = .Left
        
        self.addGestureRecognizer(rightSwipe)
        self.addGestureRecognizer(leftSwipe)
    }
    
    private func animateRight() {
        if let topBarDelegate = delegate {
            topBarDelegate.willSelectViewControllerAtIndex(1, direction: .Forward)
            UIView.animateWithDuration(0.5, delay: 0, options: .CurveEaseInOut, animations: {
                self.removeConstraint(self.indicatorXPosition)
                self.indicatorXPosition = NSLayoutConstraint(item: self.indicatorView, attribute: .CenterX, relatedBy: .Equal, toItem: self.rightButton, attribute: .CenterX, multiplier: 1, constant: 0)
                self.addConstraint(self.indicatorXPosition)
                self.layoutIfNeeded()
                }, completion: { void in
                    UIView.animateWithDuration(0.5, delay: 0, options: .CurveEaseIn, animations: {
                        self.rightButton.setTitleColor(self.buttonFontColors.selectedColor, forState: .Normal)
                        self.leftButton.setTitleColor(self.buttonFontColors.unselectedColor, forState: .Normal)
                        }, completion: nil)
            })
        }
    }
    
    private func animateLeft() {
        if let topBarDelegate = delegate {
            topBarDelegate.willSelectViewControllerAtIndex(0, direction: .Reverse)
            UIView.animateWithDuration(0.5, delay: 0, options: .CurveEaseInOut, animations: {
                self.removeConstraint(self.indicatorXPosition)
                self.indicatorXPosition = NSLayoutConstraint(item: self.indicatorView, attribute: .CenterX, relatedBy: .Equal, toItem: self.leftButton, attribute: .CenterX, multiplier: 1, constant: 0)
                self.addConstraint(self.indicatorXPosition)
                self.layoutIfNeeded()
                }, completion: { void in
                    UIView.animateWithDuration(0.5, delay: 0, options: .CurveEaseIn, animations: {
                        self.rightButton.setTitleColor(self.buttonFontColors.unselectedColor, forState: .Normal)
                        self.leftButton.setTitleColor(self.buttonFontColors.selectedColor, forState: .Normal)
                        }, completion: nil)
            })
        }
    }
    
    //MARK: - Constraints
    private func setConstraints() {
        let views = ["leftButton" : leftButton, "indicatorView" : indicatorView, "rightButton" : rightButton]
        self.addConstraints(
            NSLayoutConstraint.constraintsWithVisualFormat("V:|-9-[leftButton][indicatorView(==3)]-9-|", options: [], metrics: nil, views: views))
        self.addConstraints(
            NSLayoutConstraint.constraintsWithVisualFormat("[indicatorView(==20)]", options: [], metrics: nil, views: views))
        self.addConstraint(
            NSLayoutConstraint(item: leftButton, attribute: .Width, relatedBy: .Equal, toItem: nil, attribute: .Width, multiplier: 1, constant: 100))
        indicatorXPosition = NSLayoutConstraint(item: indicatorView, attribute: .CenterX, relatedBy: .Equal, toItem: leftButton, attribute: .CenterX, multiplier: 1, constant: 0)
        self.addConstraint(indicatorXPosition)
        self.addConstraint(
            NSLayoutConstraint(item: leftButton, attribute: .CenterX, relatedBy: .Equal, toItem: self, attribute: .CenterX, multiplier: 1, constant: -70))
        self.addConstraint(
            NSLayoutConstraint(item: rightButton, attribute: .Width, relatedBy: .Equal, toItem: nil, attribute: .Width, multiplier: 1, constant: 100))
        self.addConstraint(
            NSLayoutConstraint(item: rightButton, attribute: .Leading, relatedBy: .Equal, toItem: leftButton, attribute: .Trailing, multiplier: 1, constant: 30))
        self.addConstraints(
            NSLayoutConstraint.constraintsWithVisualFormat("V:|-9-[rightButton]-12-|", options: [], metrics: nil, views: views))
    }
}

//MARK: - PageViewTopTabBarDelegate
///Delegate for the tab bar
public protocol EVPageViewTopTabBarDelegate {
    /**
     Controls what UIViewController is displayed
     
     - Parameter index: Int, array index determining which view controller is to be displayed
     - Parameter direction: UIPageViewControllerNavigationDirection
     */
    func willSelectViewControllerAtIndex(index: Int, direction: UIPageViewControllerNavigationDirection)
}

//MARK: - Selector
private extension Selector {
    static let leftButtonTapped = #selector(EVPageViewTopTabBar.leftButtonWasTouched(_:))
    static let rightButtonTapped = #selector(EVPageViewTopTabBar.rightButtonWasTouched(_:))
    static let respondToRightSwipe = #selector(EVPageViewTopTabBar.respondToRightSwipe(_:))
    static let respondToLeftSwipe = #selector(EVPageViewTopTabBar.respondToLeftSwipe(_:))
}
