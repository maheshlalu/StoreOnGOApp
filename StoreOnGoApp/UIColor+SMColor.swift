//
//  UIColor+SMColor.swift
//  StoreOnGoApp
//
//  Created by CX_One on 8/17/16.
//  Copyright © 2016 CX. All rights reserved.
//

import Foundation

extension UIColor {
    class func signInColor() -> UIColor{
        let color = UIColor.init(red: 208.0/255.0, green: 0.0/255.0, blue: 48.0/255.0, alpha: 1.0)
        return color
    }
    
    class func signUpColor() -> UIColor {
        let bgColor = UIColor(red: 59.0/255.0, green: 59.0/255.0, blue: 59.0/255.0, alpha: 1.0)
        return bgColor
    }
    
    class func navBarColor() -> UIColor{
        let color = UIColor.init(red: 239.0/255.0, green: 75.0/255.0, blue: 38.0/255.0, alpha: 1.0)
        return color
    }
    
//    class func smOrangeColor () -> UIColor {
//        let color = UIColor(red: 252.0/255.0, green: 193.0/255.0, blue: 40.0/255.0, alpha: 1.0)
//        return color//252 193 40
//    }
    
}