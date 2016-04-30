//
//  CX_Stores+CoreDataProperties.swift
//  StoreOnGoApp
//
//  Created by Rama kuppa on 30/04/16.
//  Copyright © 2016 CX. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension CX_Stores {

    @NSManaged var id: String?
    @NSManaged var createdById: String?
    @NSManaged var jobTypeId: String?
    @NSManaged var jobTypeName: String?
    @NSManaged var name: String?
    @NSManaged var address: String?
    @NSManaged var descriptionData: String?
    @NSManaged var longitude: String?
    @NSManaged var latitude: String?
    @NSManaged var city: String?
    @NSManaged var contactNumber: String?
    @NSManaged var faceBook: String?
    @NSManaged var twitter: String?
    @NSManaged var json: String?
    @NSManaged var attachments: NSObject?

}
