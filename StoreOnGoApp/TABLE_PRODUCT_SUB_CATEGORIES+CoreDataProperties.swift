//
//  TABLE_PRODUCT_SUB_CATEGORIES+CoreDataProperties.swift
//  StoreOnGoApp
//
//  Created by Rama kuppa on 08/05/16.
//  Copyright © 2016 CX. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension TABLE_PRODUCT_SUB_CATEGORIES {

    @NSManaged var createdByFullName: String?
    @NSManaged var createdById: String?
    @NSManaged var descriptionData: String?
    @NSManaged var icon_Name: String?
    @NSManaged var icon_URL: String?
    @NSManaged var id: String?
    @NSManaged var itemCode: String?
    @NSManaged var masterCategory: String?
    @NSManaged var name: String?
    @NSManaged var subCategoryType: String?

}
