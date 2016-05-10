//
//  ProductHomeCntl.swift
//  StoreOnGoApp
//
//  Created by Rama kuppa on 08/05/16.
//  Copyright © 2016 CX. All rights reserved.
//

import UIKit

class ProductHomeCntl: UIViewController {
    var segmentedControl4 : HMSegmentedControl = HMSegmentedControl()
    var searchBar: SearchBar!
    var productCollectionView: UICollectionView!
    var productCategories: NSArray!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.whiteColor()
        self.setTheNavigationProperty()
        self.setupPager()
        self.designSearchBar()
        self.setupCollectionView()
        let predicate:NSPredicate = NSPredicate(format: "masterCategory = %@", "Products List(129121)")
        self.getProductSubCategory(predicate)
        
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
        navigationController!.navigationBar.barTintColor = UIColor.redColor()
        navigationController!.navigationBar.titleTextAttributes =
            [NSForegroundColorAttributeName: UIColor.whiteColor()]
    }
    
   
    func setupPager () {
        
        self.segmentedControl4 = HMSegmentedControl(frame: CGRectMake(0, 60, CXConstant.screenSize.width, 50))
        self.segmentedControl4.sectionTitles = ["PRODUCTS LIST", "MISCELLANEOUS"]
        self.segmentedControl4.selectedSegmentIndex = 0
        self.segmentedControl4.backgroundColor =  UIColor.whiteColor()
        self.segmentedControl4.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.blackColor()]
        self.segmentedControl4.selectedTitleTextAttributes = [NSForegroundColorAttributeName: UIColor(red: 0.1, green: 0.1, blue: 0.1, alpha: 1)]
        self.segmentedControl4.selectionIndicatorColor = UIColor.redColor()
            self.segmentedControl4.selectionStyle = HMSegmentedControlSelectionStyleBox
        self.segmentedControl4.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationUp
        self.segmentedControl4.tag = 3
        segmentedControl4.addTarget(self, action: #selector(ProductHomeCntl.segmentedControlChangedValue(_:)), forControlEvents: .ValueChanged)
        self.view.addSubview(self.segmentedControl4)
        
        //Miscellaneous(135918)
    }
    
    //MARK : SearchBar
    func designSearchBar (){
        
        self.searchBar = SearchBar.designSearchBar()
        self.searchBar.delegate = self
        self.searchBar.placeholder = "Search Products Categories"
        self.view.addSubview(self.searchBar)
    }
    
    
    func setupCollectionView (){
        
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 20, left: 10, bottom: 200, right: 10)
        layout.itemSize = CXConstant.ProductCollectionCellSize
        //self.view.frame
        self.productCollectionView = UICollectionView(frame:CGRectMake(0,CXConstant.searchBarFrame.origin.y+CXConstant.searchBarFrame.size.height, CXConstant.screenSize.width, CXConstant.screenSize.height), collectionViewLayout: layout)
        self.productCollectionView.showsHorizontalScrollIndicator = false
        self.productCollectionView.delegate = self
        self.productCollectionView.dataSource = self
        layout.scrollDirection = UICollectionViewScrollDirection.Vertical
        self.productCollectionView.registerClass(ProductCollectionCell.self, forCellWithReuseIdentifier: "ProductCollectionCell")
        self.productCollectionView.backgroundColor = UIColor.clearColor()
        self.view.addSubview(self.productCollectionView)
    }
    
    
    func getProductSubCategory (predicate:NSPredicate){
        //let fetchRequest = NSFetchRequest(entityName: "TABLE_PRODUCT_SUB_CATEGORIES")
        
        let productEn = NSEntityDescription.entityForName("TABLE_PRODUCT_SUB_CATEGORIES", inManagedObjectContext: NSManagedObjectContext.MR_contextForCurrentThread())
       let fetchRequest = TABLE_PRODUCT_SUB_CATEGORIES.MR_requestAllSortedBy("name", ascending: true)
        fetchRequest.predicate = predicate
        fetchRequest.entity = productEn
        self.productCategories =   TABLE_PRODUCT_SUB_CATEGORIES.MR_executeFetchRequest(fetchRequest)
        self.productCollectionView.reloadData()

        
    }
    
    //+ (NSFetchRequest *) MR_requestAllSortedBy:(NSString *)sortTerm ascending:(BOOL)ascending inContext:(NSManagedObjectContext *)context

    //self.beers = [[Beer findAllSortedBy:SORT_KEY_NAME ascending:YES withPredicate:[NSPredicate predicateWithFormat:@"name contains[c] %@", searchText] inContext:[NSManagedObjectContext defaultContext]] mutableCopy];
    //SELECT * FROM ZTABLE_PRODUCT_SUB_CATEGORIES WHERE ZMASTERCATEGORY = 'Products List(129121)'
    //SELECT * FROM ZTABLE_PRODUCT_SUB_CATEGORIES WHERE ZMASTERCATEGORY = 'Miscellaneous(135918)'

    
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    func segmentedControlChangedValue(segmentedControl: HMSegmentedControl) {
        NSLog("Selected index %ld (via UIControlEventValueChanged)", Int(segmentedControl.selectedSegmentIndex))
        
        let index = Int(segmentedControl.selectedSegmentIndex)
        
        switch index {
        case 0  :
            let predicate:NSPredicate = NSPredicate(format: "masterCategory = %@", "Products List(129121)")
            self.getProductSubCategory(predicate)
            break
        case 1 :
            let predicate:NSPredicate = NSPredicate(format: "masterCategory = %@", "Miscellaneous(135918)")
            self.getProductSubCategory(predicate)
            break
            
        default :
            break
        }

     
    }
    
    func uisegmentedControlChangedValue(segmentedControl: UISegmentedControl) {
        NSLog("Selected index %ld", Int(segmentedControl.selectedSegmentIndex))
        
    }
}

extension ProductHomeCntl:UISearchBarDelegate{
    func searchBarSearchButtonClicked( searchBar: UISearchBar)
    {
        
    }
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        print("search string \(searchText)")
        
    }

    
}


extension ProductHomeCntl:UICollectionViewDelegate,UICollectionViewDataSource {
    
    func collectionView(collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        // let prodCategory:CX_Product_Category = self.mallProductCategories[collectionView.tag] as! CX_Product_Category
        // let products:NSArray = self.getProducts(prodCategory)
        
        return self.productCategories.count;
    }
    
    func collectionView(collectionView: UICollectionView,
                        cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let identifier = "ProductCollectionCell"
        let cell: ProductCollectionCell! = collectionView.dequeueReusableCellWithReuseIdentifier(identifier, forIndexPath: indexPath) as?ProductCollectionCell
        if cell == nil {
            collectionView.registerNib(UINib(nibName: "ProductCollectionCell", bundle: nil), forCellWithReuseIdentifier: identifier)
        }
        
        let proCat : TABLE_PRODUCT_SUB_CATEGORIES = self.productCategories[indexPath.row] as! TABLE_PRODUCT_SUB_CATEGORIES
        
        cell.textLabel.text = proCat.name
        
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        print("Collection view at row \(collectionView.tag) selected index path \(indexPath) indexPath Row\(indexPath.row)")
        
        let index = indexPath.row
        
        //select *from ZCX_PRODUCTS where ZSUBCATNAMEID = 'FORK GUIDE BOLT(130603)'

        
    }
    
   /* func collectionView(collectionView: UICollectionView!, layout collectionViewLayout: UICollectionViewLayout!, sizeForItemAtIndexPath indexPath: NSIndexPath!) -> CGSize {
        
        //CGSize(width:screenSize.width/3.8,height: 40)
        
        let cell = ProductCollectionCell(frame: CGRect(x: 0, y: 8, width: CXConstant.screenSize.width/3.8, height: 40))
        let proCat : TABLE_PRODUCT_SUB_CATEGORIES = self.productCategories[indexPath.row] as! TABLE_PRODUCT_SUB_CATEGORIES

        cell.textLabel.text = proCat.name

         let font = UIFont(name: "Helvetica", size: 24)
        
            let fontAttributes = [NSFontAttributeName: font] // it says name, but a UIFont works
            let myText = "Your Text Here"
            let size = (myText as NSString).sizeWithAttributes(fontAttributes)
        
        return CGSizeMake(cell.textLabel.intrinsicContentSize().width+10, cell.textLabel.intrinsicContentSize().height+20)
    }
    */
    
    
}

/*#pragma mark - Search Bar Delegate
 - (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
	if ([self.searchBar.text length] > 0) {
 [self doSearch];
	} else {
 [self fetchAllBeers];
 [self.tableView reloadData];
	}
 }
 
 - (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
	[self.searchBar resignFirstResponder];
	// Clear search bar text
	self.searchBar.text = @"";
	// Hide the cancel button
	self.searchBar.showsCancelButton = NO;
	// Do a default fetch of the beers
	[self fetchAllBeers];
	[self.tableView reloadData];
 }
 
 - (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
	self.searchBar.showsCancelButton = YES;
 }
 
 - (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
	[self.searchBar resignFirstResponder];
	[self doSearch];
 }
 
 - (void)doSearch {
	// 1. Get the text from the search bar.
	NSString *searchText = self.searchBar.text;
	// 2. Do a fetch on the beers that match Predicate criteria.
	// In this case, if the name contains the string
	self.beers = [[Beer findAllSortedBy:SORT_KEY_NAME
 ascending:YES
 withPredicate:[NSPredicate predicateWithFormat:@"name contains[c] %@", searchText]
 inContext:[NSManagedObjectContext defaultContext]] mutableCopy];
	// 3. Reload the table to show the query results.
	[self.tableView reloadData];
 }
*/


