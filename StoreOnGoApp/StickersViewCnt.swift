//
//  StickersViewCnt.swift
//  StoreOnGoApp
//
//  Created by Rama kuppa on 06/07/16.
//  Copyright © 2016 CX. All rights reserved.
//

import UIKit

class StickersViewCnt: UIViewController {
    var stickersCollectionView: UICollectionView!
    var stickersList : NSArray = NSArray()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupCollectionView()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func setupCollectionView(){
        
        func setupCollectionView (){
            
            let layout = UICollectionViewFlowLayout()
            layout.sectionInset = UIEdgeInsets(top: 20, left: 10, bottom: 50, right: 10)
            layout.itemSize = CXConstant.DetailCollectionCellSize
            self.stickersCollectionView = UICollectionView(frame: CXConstant.collectionFram, collectionViewLayout: layout)
            self.stickersCollectionView.showsHorizontalScrollIndicator = false
            layout.scrollDirection = UICollectionViewScrollDirection.Vertical
            self.stickersCollectionView.registerClass(CX_StickerCell.self, forCellWithReuseIdentifier: "CX_StickerCell")
            self.stickersCollectionView.backgroundColor = UIColor.clearColor()
            self.view.addSubview(self.stickersCollectionView)
            //self.setCollectionViewDataSourceDelegate(self, forRow: 0)
            
        }
        
        func setCollectionViewDataSourceDelegate<D: protocol<UICollectionViewDataSource, UICollectionViewDelegate>>(dataSourceDelegate: D, forRow row: Int) {
            self.stickersCollectionView.delegate = dataSourceDelegate
            self.stickersCollectionView.dataSource = dataSourceDelegate
            self.stickersCollectionView.reloadData()
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
        // cell.backgroundColor = UIColor.redColor()
       // cell.titleLabel.text = stickersList[indexPath.row]
       // cell.iconImageView.image = UIImage(named: stickersList[indexPath.row])
        return cell
   }
}
