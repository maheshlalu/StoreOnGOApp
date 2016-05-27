//
//  FeatureProductsCnt.swift
//  StoreOnGoApp
//
//  Created by Rama kuppa on 01/05/16.
//  Copyright © 2016 CX. All rights reserved.
//

import UIKit

class FeatureProductsCnt: UIViewController {
    var feturedProductTbl: UITableView!
    var headerview: HeaderView!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.customizeView()
        self.setTheNavigationProperty()

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
    
    func customizeView () {
        self.feturedProductTbl = self.customizeTableView(CGRectMake(0, 0, CXConstant.screenSize.width, CXConstant.screenSize.height-CXConstant.headerViewHeigh))
        self.view.addSubview(self.feturedProductTbl)
        
    }
    
    func designHeaderView (){
        
        self.headerview = HeaderView.customizeHeaderView(true, headerTitle: "",backButtonVisible: true)
        self.view.addSubview(self.headerview)
        
    }

    func customizeTableView (tFrame:CGRect) ->UITableView {
        
        let tabView:UITableView = UITableView.init(frame: tFrame)
        tabView.delegate = self
        tabView.dataSource = self
        tabView.backgroundColor = UIColor.clearColor()
        tabView.registerClass(CXDetailTableViewCell.self, forCellReuseIdentifier: "DetailCell")
        tabView.separatorStyle = UITableViewCellSeparatorStyle.None
        tabView.contentInset = UIEdgeInsetsMake(0, 0,60, 0)
        tabView.rowHeight = UITableViewAutomaticDimension
        tabView.scrollEnabled = false
        return tabView;

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

extension FeatureProductsCnt : UITableViewDelegate,UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let identifier = "DetailCell"
        
        var cell: CXDetailTableViewCell! = tableView.dequeueReusableCellWithIdentifier(identifier) as? CXDetailTableViewCell
        if cell == nil {
            tableView.registerNib(UINib(nibName: "CXDetailTableViewCell", bundle: nil), forCellReuseIdentifier: identifier)
            cell = tableView.dequeueReusableCellWithIdentifier(identifier) as? CXDetailTableViewCell
        }
        cell.setCollectionViewDataSourceDelegate(self, forRow: indexPath.row)
       // cell.collectionViewOffset = storedOffsets[indexPath.row] ?? 0
        
        //cell.headerLbl.text = self.detailItems[indexPath.row]
        
        return cell;
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return CXConstant.tableViewHeigh;
    }

}



extension FeatureProductsCnt: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return 5;
        //return model[collectionView.tag].count
    }
    
    func collectionView(collectionView: UICollectionView,
                        cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let identifier = "DetailCollectionViewCell"
        let cell: CXDetailCollectionViewCell! = collectionView.dequeueReusableCellWithReuseIdentifier(identifier, forIndexPath: indexPath) as?CXDetailCollectionViewCell
        if cell == nil {
            collectionView.registerNib(UINib(nibName: "CXDetailCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: identifier)
        }
        //let cacheKey : String = String(indexPath.row+1)
        cell.detailImageView.image = UIImage(named:"smlogo.png")
        cell.detailImageView.contentMode = UIViewContentMode.ScaleAspectFit
        cell.infoLabel.text = "Silly Monks and we believe theat"
        
                return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        print("Collection view at row \(collectionView.tag) selected index path \(indexPath) indexPath Row\(indexPath.row)")
        //let galleryView = CXGalleryViewController.init()
//        self.navigationController?.pushViewController(galleryView, animated: true)
        }
   
}




