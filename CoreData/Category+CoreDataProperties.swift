//
//  Category+CoreDataProperties.swift
//  DecAR
//
//  Created by iosdev on 23.11.2022.
//

import Foundation
import CoreData

extension Category {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Category> {
        return NSFetchRequest<Category>(entityName: "Category")
    }

    @NSManaged public var CategoryName: String?
    @NSManaged public var furnitureINCategory: NSSet?

}

extension Category {

    @objc(addFurnitureObject:)
    @NSManaged public func addToFurniture(_ value: Furniture)

    @objc(removeFurnitureObject:)
    @NSManaged public func removeFromFurnitue(_ value: Furniture)

    @objc(addFurniture:)
    @NSManaged public func addToFurniture(_ values: NSSet)

    @objc(removeFurniture:)
    @NSManaged public func removeFromFurniture(_ values: NSSet)

}

extension Category : Identifiable {

}
