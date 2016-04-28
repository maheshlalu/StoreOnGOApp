//
//  CX_Products+CoreDataProperties.h
//  StoreOnGoApp
//
//  Created by Mahesh Y on 28/04/16.
//  Copyright © 2016 CX. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "CX_Products.h"

NS_ASSUME_NONNULL_BEGIN

@interface CX_Products (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *addToCart;
@property (nullable, nonatomic, retain) NSString *createdByID;
@property (nullable, nonatomic, retain) NSString *favourite;
@property (nullable, nonatomic, retain) NSString *itemCode;
@property (nullable, nonatomic, retain) NSString *json;
@property (nullable, nonatomic, retain) NSString *mallID;
@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) NSString *pID;
@property (nullable, nonatomic, retain) NSString *quantity;
@property (nullable, nonatomic, retain) NSString *storeID;
@property (nullable, nonatomic, retain) NSString *subCatNameID;
@property (nullable, nonatomic, retain) NSString *type;

@end

NS_ASSUME_NONNULL_END
