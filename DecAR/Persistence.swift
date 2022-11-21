//
//  Persistence.swift
//  DecAR
//
//  Created by iosdev on 20.11.2022.
//

import Foundation
import CoreData

struct PersistenceController {
    static let shared = PersistenceController()

    // For preview only
    static var preview: PersistenceController = {
        let result = PersistenceController(inMemory: true)
        let viewContext = result.container.viewContext
        for _ in 0..<10 {
            let newListing = Listing(context: viewContext)
            newListing.clientName = "Janne"
            newListing.clientAddress = "Koulutie 12"
        }
        do {
            try viewContext.save()
        } catch {
           
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
        return result
    }()

    let container: NSPersistentContainer

    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "DecAR")
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        container.viewContext.automaticallyMergesChangesFromParent = true
    }
}
