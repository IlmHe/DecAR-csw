//
//  AppDelegate.swift
//  DecAR
//
//  Created by iosdev on 16.11.2022.
//

import UIKit
import SwiftUI
import CoreData

@main


struct DecARCoreDataApp: App {
    let persistenceController = PersistenceController.shared
    init() {
        createBaseFurnitures()

    }

    func createBaseFurnitures() {
        if UserDefaults.standard.object(forKey: "AppLaunched") == nil {
            
            let appFirstLaunch = UserDefaults.standard
            appFirstLaunch.set(100, forKey: "AppLaunched")
            
            //Persistent container
            let persistentContainer: NSPersistentContainer = {
                let container = NSPersistentContainer(name: "DecAR")
                container.loadPersistentStores { description, error in
                    if let error = error {
                        fatalError("Unable to load persistent stores: \(error)")
                    }
                }
                return container
            }()
            let furnitureContext = persistentContainer.viewContext
            furnitureContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
            let redChair = Furniture(context: furnitureContext)
            redChair.furnitureName = "Swan chair"
            redChair.modelName = "chair_swan"
            redChair.category = "Chairs"
            
            let couch = Furniture(context: furnitureContext)
            couch.furnitureName = "Brown cuch"
            couch.modelName = "brown_couch"
            couch.category = "Couches"
            
            let stool = Furniture(context: furnitureContext)
            stool.furnitureName = "Stool"
            stool.modelName = "stool"
            stool.category = "Stools"

            let baseFurniture3 = Furniture(context: furnitureContext)
            baseFurniture3.furnitureName = "Old painting"
            baseFurniture3.modelName = "old_painting"
            baseFurniture3.category = "Paintigs"

            let baseFurniture6 = Furniture(context: furnitureContext)
            baseFurniture6.furnitureName = "Gaming desk"
            baseFurniture6.modelName = "gaming_desk"
            baseFurniture6.category = "Desks"
            
            let baseFurniture7 = Furniture(context: furnitureContext)
            baseFurniture7.furnitureName = "Flowerpot"
            baseFurniture7.modelName = "flowerpot"
            baseFurniture7.category = "Flower"

            let baseFurniture10 = Furniture(context: furnitureContext)
            baseFurniture10.furnitureName = "Steelframe shelve"
            baseFurniture10.modelName = "steelframe_shelve"
            baseFurniture10.category = "Shelves"

            let baseFurniture11 = Furniture(context: furnitureContext)
            baseFurniture11.furnitureName = "Striped carpet"
            baseFurniture11.modelName = "striped_carpet"
            baseFurniture11.category = "Carpet"

            let baseFurniture12 = Furniture(context: furnitureContext)
            baseFurniture12.furnitureName = "Vase"
            baseFurniture12.modelName = "vase"
            baseFurniture12.category = "Vases"
            
            let baseFurniture26 = Furniture(context: furnitureContext)
            baseFurniture26.furnitureName = "House plant"
            baseFurniture26.modelName = "house_plant"
            baseFurniture26.category = "Plants"
            
            let baseFurniture29 = Furniture(context: furnitureContext)
            baseFurniture29.furnitureName = "Egg chair"
            baseFurniture29.modelName = "egg_chair"
            baseFurniture29.category = "Chairs"
            
            let baseFurniture30 = Furniture(context: furnitureContext)
            baseFurniture30.furnitureName = "Modern TV stand"
            baseFurniture30.modelName = "modern_tv_stand"
            baseFurniture30.category = "TV stands"
            
            let baseFurniture34 = Furniture(context: furnitureContext)
            baseFurniture34.furnitureName = "Table set"
            baseFurniture34.modelName = "table_set"
            baseFurniture34.category = "Sets"
            
            let baseFurniture35 = Furniture(context: furnitureContext)
            baseFurniture35.furnitureName = "Wall television"
            baseFurniture35.modelName = "wall_televison"
            baseFurniture35.category = "Televions"
            
            let baseFurniture36 = Furniture(context: furnitureContext)
            baseFurniture36.furnitureName = "Art desk"
            baseFurniture36.modelName = "art_desk"
            baseFurniture36.category = "Deks"
            
            let baseFurniture37 = Furniture(context: furnitureContext)
            baseFurniture37.furnitureName = "Wooden table"
            baseFurniture37.modelName = "wooden_table"
            baseFurniture37.category = "Tables"
            
            let baseFurniture38 = Furniture(context: furnitureContext)
            baseFurniture38.furnitureName = "Wooden bookshelf"
            baseFurniture38.modelName = "wooden_bookshelf"
            baseFurniture38.category = "Shelves"
            
            let baseFurniture39 = Furniture(context: furnitureContext)
            baseFurniture39.furnitureName = "Piano black"
            baseFurniture39.modelName = "piano_black"
            baseFurniture39.category = "Pianos"
            
            let baseFurniture41 = Furniture(context: furnitureContext)
            baseFurniture41.furnitureName = "Divan sofa"
            baseFurniture41.modelName = "divan_sofa"
            baseFurniture41.category = "Sofas"
            
            let baseFurniture43 = Furniture(context: furnitureContext)
            baseFurniture43.furnitureName = "Wooden bed"
            baseFurniture43.modelName = "wooden_bed"
            baseFurniture43.category = "Beds"
            
            let baseFurniture45 = Furniture(context: furnitureContext)
            baseFurniture45.furnitureName = "Bunk bed"
            baseFurniture45.modelName = "bunk_bed"
            baseFurniture45.category = "Beds"
            
            let baseFurniture46 = Furniture(context: furnitureContext)
            baseFurniture46.furnitureName = "Office chair"
            baseFurniture46.modelName = "office_chair"
            baseFurniture46.category = "Chairs"
            
            let baseFurniture47 = Furniture(context: furnitureContext)
            baseFurniture47.furnitureName = "Grey sofa"
            baseFurniture47.modelName = "grey_sofa"
            baseFurniture47.category = "Sofas"
            
            let baseFurniture48 = Furniture(context: furnitureContext)
            baseFurniture48.furnitureName = "Armchair"
            baseFurniture48.modelName = "armchair"
            baseFurniture48.category = "Chairs"
            
            let baseFurniture49 = Furniture(context: furnitureContext)
            baseFurniture49.furnitureName = "Chesterfield sofa"
            baseFurniture49.modelName = "chesterfield_sofa"
            baseFurniture49.category = "Sofas"
            
            let context = persistentContainer.viewContext
            if context.hasChanges {
                print("Täällä käytiin")
                do {
                    try context.save()
                } catch {
                    let nserror = error as NSError
                    fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
                }
            }
        }
    }

    var body: some Scene {

        WindowGroup {

            ContentView(currentObject: .constant(SelectedFurniture("stool")))
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}

class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    //Persistent container
    lazy var persistentContainer: NSPersistentContainer = {
            let container = NSPersistentContainer(name: "DecAR")
            container.loadPersistentStores { description, error in
                if let error = error {
                    fatalError("Unable to load persistent stores: \(error)")
                }
            }
            return container
        }()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        // Create the SwiftUI view that provides the window contents.
        let contentView = ContentView(currentObject: .constant(SelectedFurniture("stool")))
    
        // Use a UIHostingController as window root view controller.
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.rootViewController = UIHostingController(rootView: contentView)
        self.window = window
        window.makeKeyAndVisible()
        return true
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
}

