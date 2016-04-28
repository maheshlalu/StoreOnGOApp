//
//  CX_Product_Category+CoreDataProperties.h
//  StoreOnGoApp
//
//  Created by Mahesh Y on 28/04/16.
//  Copyright © 2016 CX. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "CX_Product_Category.h"

NS_ASSUME_NONNULL_BEGIN

@interface CX_Product_Category (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *categoryMall;
@property (nullable, nonatomic, retain) NSString *createdByFullName;
@property (nullable, nonatomic, retain) NSString *createdById;
@property (nullable, nonatomic, retain) NSString *createdOn;
@property (nullable, nonatomic, retain) NSString *currentJobStatus;
@property (nullable, nonatomic, retain) NSString *icon_name;
@property (nullable, nonatomic, retain) NSString *icon_url;
@property (nullable, nonatomic, retain) NSString *itemCode;
@property (nullable, nonatomic, retain) NSString *jobTypeID;
@property (nullable, nonatomic, retain) NSString *jobTypeName;
@property (nullable, nonatomic, retain) NSString *mallID;
@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) NSString *overallRating;
@property (nullable, nonatomic, retain) NSString *packageName;
@property (nullable, nonatomic, retain) NSString *pid;
@property (nullable, nonatomic, retain) NSString *productDescription;
@property (nullable, nonatomic, retain) NSString *publicUrl;
@property (nullable, nonatomic, retain) NSString *storeID;
@property (nullable, nonatomic, retain) NSString *totalReviews;

@end

NS_ASSUME_NONNULL_END
