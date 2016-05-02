//
//  CXDetailTableViewCell.swift
//  Silly Monks
//
//  Created by Sarath on 09/04/16.
//  Copyright © 2016 Sarath. All rights reserved.
//

import UIKit

class CXDetailTableViewCell: UITableViewCell {

    var bgView : UIView = UIView()
    var headerLbl: UILabel = UILabel()
    var detailCollectionView: UICollectionView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override init(style : UITableViewCellStyle, reuseIdentifier:String?){
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = UIColor.whiteColor()
        self.backgroundView?.backgroundColor = UIColor.clearColor()
        self.selectionStyle = UITableViewCellSelectionStyle.None
        self.customizeBgView()
        self.customizeDetailCollectionView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        
    }
    
    func customizeBgView(){
        self.bgView.frame = CGRectMake(15, 5, CXConstant.DetailTableView_Width-30, CXConstant.tableViewHeigh-10)
        self.bgView.layer.borderColor = UIColor.grayColor().CGColor
        self.bgView.layer.borderWidth = 1.0
        self.bgView.backgroundColor = UIColor.whiteColor()
        self.addSubview(self.bgView)
        
        self.headerLbl.frame = CGRectMake(0, 0, self.bgView.frame.size.width, 30)
        self.headerLbl.font = UIFont(name:"Roboto-Bold", size:16)
        self.headerLbl.textAlignment = NSTextAlignment.Center
        self.headerLbl.textColor = UIColor.grayColor() //CXConstant.titleLabelColor
        self.bgView.addSubview(self.headerLbl)
    }
    
    func customizeDetailCollectionView(){
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CXConstant.DetailCollectionCellSize
        self.detailCollectionView = UICollectionView(frame: CGRectZero, collectionViewLayout: layout)
        self.detailCollectionView.showsHorizontalScrollIndicator = false
        self.detailCollectionView.frame = CXConstant.DetailCollectionViewFrame
        layout.scrollDirection = UICollectionViewScrollDirection.Horizontal
        self.detailCollectionView.registerClass(CXDetailCollectionViewCell.self, forCellWithReuseIdentifier: "DetailCollectionViewCell")
        self.detailCollectionView.backgroundColor = UIColor.clearColor()
        self.addSubview(self.detailCollectionView)
    }
}


extension CXDetailTableViewCell{
    
    var collectionViewOffset: CGFloat {
        set {
            self.detailCollectionView.contentOffset.x = newValue
        }
        get {
            return detailCollectionView.contentOffset.x
        }
    }
    
    func setCollectionViewDataSourceDelegate<D: protocol<UICollectionViewDataSource, UICollectionViewDelegate>>(dataSourceDelegate: D, forRow row: Int) {
        self.detailCollectionView.delegate = dataSourceDelegate
        self.detailCollectionView.dataSource = dataSourceDelegate
        self.detailCollectionView.tag = row
        self.detailCollectionView.reloadData()
    }
    
}