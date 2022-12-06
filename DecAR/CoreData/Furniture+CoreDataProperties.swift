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

    @NSManaged public var furnitureName: String?
    @NSManaged public var category: String?
    @NSManaged public var modelName: String?
}

extension Furniture {

}

extension Furniture : Identifiable {

}
