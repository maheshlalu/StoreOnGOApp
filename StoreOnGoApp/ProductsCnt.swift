//
//  ProductsCnt.swift
//  StoreOnGoApp
//
//  Created by Rama kuppa on 29/04/16.
//  Copyright © 2016 CX. All rights reserved.
//

import UIKit

class ProductsCnt: UIViewController {
    var productCollectionView: UICollectionView!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.whiteColor()
        self.setupCollectionView()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupCollectionView (){
        
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 20, left: 10, bottom: 10, right: 10)
        layout.itemSize = CXConstant.DetailCollectionCellSize
        self.productCollectionView = UICollectionView(frame: CXConstant.collectionFram, collectionViewLayout: layout)
        self.productCollectionView.showsHorizontalScrollIndicator = false
        layout.scrollDirection = UICollectionViewScrollDirection.Vertical
        self.productCollectionView.registerClass(HomeCollectionViewCell.self, forCellWithReuseIdentifier: "HomeCollectionViewCell")
        self.productCollectionView.backgroundColor = UIColor.clearColor()
        self.view.addSubview(self.productCollectionView)
        
    }
    
    
    
}

extension ProductsCnt:UICollectionViewDelegate,UICollectionViewDataSource {
    
    func collectionView(collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        // let prodCategory:CX_Product_Category = self.mallProductCategories[collectionView.tag] as! CX_Product_Category
        // let products:NSArray = self.getProducts(prodCategory)
        
        return 50;
    }
    
    func collectionView(collectionView: UICollectionView,
                        cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let identifier = "HomeCollectionViewCell"
        let cell: HomeCollectionViewCell! = collectionView.dequeueReusableCellWithReuseIdentifier(identifier, forIndexPath: indexPath) as?HomeCollectionViewCell
        if cell == nil {
            collectionView.registerNib(UINib(nibName: "HomeCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: identifier)
        }
        cell.backgroundColor = UIColor.redColor()
        return cell
    }
    
    
    
}
