//
//  SearchBar.swift
//  StoreOnGoApp
//
//  Created by Rama kuppa on 01/05/16.
//  Copyright © 2016 CX. All rights reserved.
//

import UIKit

class SearchBar: UISearchBar {

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

    class func designSearchBar () -> SearchBar{
        
        let searchBar : SearchBar = SearchBar.init(frame: CXConstant.searchBarFrame)

        return searchBar
    }
    
}
