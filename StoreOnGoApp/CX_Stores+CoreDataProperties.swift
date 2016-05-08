//
//  CX_Stores+CoreDataProperties.swift
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

extension CX_Stores {

    @NSManaged var address: String?
    @NSManaged var attachments: NSObject?
    @NSManaged var city: String?
    @NSManaged var contactNumber: String?
    @NSManaged var createdById: String?
    @NSManaged var descriptionData: String?
    @NSManaged var faceBook: String?
    @NSManaged var id: String?
    @NSManaged var jobTypeId: String?
    @NSManaged var jobTypeName: String?
    @NSManaged var json: String?
    @NSManaged var latitude: String?
    @NSManaged var longitude: String?
    @NSManaged var name: String?
    @NSManaged var twitter: String?

}
