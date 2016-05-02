//
//  CX_FeaturedProducts+CoreDataProperties.swift
//  StoreOnGoApp
//
//  Created by Mahesh Y on 02/05/16.
//  Copyright © 2016 CX. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension CX_FeaturedProducts {

    @NSManaged var id: String?
    @NSManaged var itemCode: String?
    @NSManaged var jobTypeId: String?
    @NSManaged var jobTypeName: String?
    @NSManaged var createdByFullName: String?
    @NSManaged var name: String?
    @NSManaged var publicURL: String?
    @NSManaged var campaign_Jobs: String?

}
