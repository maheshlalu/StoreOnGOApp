//
//  CX_CollectionViewController.swift
//  StoreOnGoApp
//
//  Created by Rama kuppa on 15/06/16.
//  Copyright © 2016 CX. All rights reserved.
//

import UIKit

private let reuseIdentifier = "CX_StickerCell"

class CX_CollectionViewController: UICollectionViewController {
    
    var stickersList : NSArray = NSArray()

 
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        self.collectionView!.registerClass(CX_StickerCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        let predicate:NSPredicate = NSPredicate(format: "masterCategory = %@", "Sticker(139455)")
        self.getProductSubCategory(predicate)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getProductSubCategory (predicate:NSPredicate){
        //let fetchRequest = NSFetchRequest(entityName: "TABLE_PRODUCT_SUB_CATEGORIES")
        
        let productEn = NSEntityDescription.entityForName("TABLE_PRODUCT_SUB_CATEGORIES", inManagedObjectContext: NSManagedObjectContext.MR_contextForCurrentThread())
        let fetchRequest = TABLE_PRODUCT_SUB_CATEGORIES.MR_requestAllSortedBy("name", ascending: true)
        fetchRequest.predicate = predicate
        fetchRequest.entity = productEn
        self.stickersList =   TABLE_PRODUCT_SUB_CATEGORIES.MR_executeFetchRequest(fetchRequest)
        self.collectionView!.reloadData()
        
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return self.stickersList.count
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
       // let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath)
        
        let identifier = reuseIdentifier
        let cell: CX_StickerCell! = collectionView.dequeueReusableCellWithReuseIdentifier(identifier, forIndexPath: indexPath) as?CX_StickerCell
        if cell == nil {
            collectionView.registerNib(UINib(nibName: "CX_StickerCell", bundle: nil), forCellWithReuseIdentifier: identifier)
        }
        
        let proCat : TABLE_PRODUCT_SUB_CATEGORIES = self.stickersList[indexPath.row] as! TABLE_PRODUCT_SUB_CATEGORIES
        
       // cell.productNameLbl.text = proCat.name!
    
        // Configure the cell
    
        return cell
    }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(collectionView: UICollectionView, shouldHighlightItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(collectionView: UICollectionView, shouldSelectItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(collectionView: UICollectionView, shouldShowMenuForItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return false
    }

    override func collectionView(collectionView: UICollectionView, canPerformAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) -> Bool {
        return false
    }

    override func collectionView(collectionView: UICollectionView, performAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) {
    
    }
    */

}
