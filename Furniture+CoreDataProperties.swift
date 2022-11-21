//
//  Furniture+CoreDataProperties.swift
//  DecAR
//
//  Created by iosdev on 20.11.2022.
//

import Foundation
import CoreData

extension Furniture {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Furniture> {
        return NSFetchRequest<Furniture>(entityName: "Furniture")
    }

    @NSManaged public var FurnitureName: String?
    @NSManaged public var furnitureCategory: String?
    @NSManaged public var forClient: NSSet?

}

extension Furniture {

    @objc(addListingObject:)
    @NSManaged public func addToListing(_ value: Listing)

    @objc(removeListingObject:)
    @NSManaged public func removeFromListing(_ value: Listing)

    @objc(addListing:)
    @NSManaged public func addToListing(_ values: NSSet)

    @objc(removeListing:)
    @NSManaged public func removeFromListing(_ values: NSSet)

}

extension Furniture : Identifiable {

}
