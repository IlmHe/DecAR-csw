//
//  Listing+CoreDataProperties.swift
//  DecAR
//
//  Created by iosdev on 20.11.2022.
//

import Foundation
import CoreData

extension Listing {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Listing> {
        return NSFetchRequest<Listing>(entityName: "Listing")
    }
    
    @NSManaged public var clientName: String?
    @NSManaged public var clientAddress: String?
}

extension Listing : Identifiable {
    
}
