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
           
            let baseFurniture1 = Furniture(context: furnitureContext)
            baseFurniture1.furnitureName = "Modern bed"
            baseFurniture1.modelName = "modern_bed"
            baseFurniture1.category = "Beds"

            let baseFurniture2 = Furniture(context: furnitureContext)
            baseFurniture2.furnitureName = "Bed with lamp"
            baseFurniture2.modelName = "bed_with_lamp"
            baseFurniture2.category = "Beds"

            let baseFurniture3 = Furniture(context: furnitureContext)
            baseFurniture3.furnitureName = "Old painting"
            baseFurniture3.modelName = "old_painting"
            baseFurniture3.category = "Paintigs"

            let baseFurniture4 = Furniture(context: furnitureContext)
            baseFurniture4.furnitureName = "Painting"
            baseFurniture4.modelName = "painting"
            baseFurniture4.category = "Paintings"

            let baseFurniture5 = Furniture(context: furnitureContext)
            baseFurniture5.furnitureName = "Japanese lamp"
            baseFurniture5.modelName = "japanense_lamp"
            baseFurniture5.category = "Lamps"

            let baseFurniture6 = Furniture(context: furnitureContext)
            baseFurniture6.furnitureName = "Gaming desk"
            baseFurniture6.modelName = "gaming_desk"
            baseFurniture6.category = "Desks"
            
            let baseFurniture7 = Furniture(context: furnitureContext)
            baseFurniture7.furnitureName = "Flowerpot"
            baseFurniture7.modelName = "flowerpot"
            baseFurniture7.category = "Flower"
            
            let baseFurniture8 = Furniture(context: furnitureContext)
            baseFurniture8.furnitureName = "Sculpture"
            baseFurniture8.modelName = "sculpture"
            baseFurniture8.category = "Sculptures"

            let baseFurniture9 = Furniture(context: furnitureContext)
            baseFurniture9.furnitureName = "Wooden nightstand"
            baseFurniture9.modelName = "wooden_nightstand"
            baseFurniture9.category = "Stands"

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
            
            let baseFurniture13 = Furniture(context: furnitureContext)
            baseFurniture13.furnitureName = "Grey carpet"
            baseFurniture13.modelName = "grey_carpet"
            baseFurniture13.category = "Carpets"

            let baseFurniture14 = Furniture(context: furnitureContext)
            baseFurniture14.furnitureName = "Fluffy carpet"
            baseFurniture14.modelName = "fluffy_carpet"
            baseFurniture14.category = "Carpets"
            
            let baseFurniture15 = Furniture(context: furnitureContext)
            baseFurniture15.furnitureName = "Chinese tea tablset"
            baseFurniture15.modelName = "chinese_tea_tablseset"
            baseFurniture15.category = "Tableset"
            
            let baseFurniture16 = Furniture(context: furnitureContext)
            baseFurniture16.furnitureName = "Classis mirror"
            baseFurniture16.modelName = "classic_mirror"
            baseFurniture16.category = "Mirrors"
            
            let baseFurniture17 = Furniture(context: furnitureContext)
            baseFurniture17.furnitureName = "Work desk"
            baseFurniture17.modelName = "work_desk"
            baseFurniture17.category = "Desks"
            
            let baseFurniture18 = Furniture(context: furnitureContext)
            baseFurniture18.furnitureName = "Glass table set"
            baseFurniture18.modelName = "glass_table_set"
            baseFurniture18.category = "Tableset"
            
            let baseFurniture19 = Furniture(context: furnitureContext)
            baseFurniture19.furnitureName = "Coffee table"
            baseFurniture19.modelName = "coffee_table"
            baseFurniture19.category = "Tables"
            
            let baseFurniture20 = Furniture(context: furnitureContext)
            baseFurniture20.furnitureName = "White glass coffee table"
            baseFurniture20.modelName = "white_glass_coffeetable"
            baseFurniture20.category = "Tables"
            
            let baseFurniture21 = Furniture(context: furnitureContext)
            baseFurniture21.furnitureName = "Black chair"
            baseFurniture21.modelName = "black_chair"
            baseFurniture21.category = "Chairs"
            
            let baseFurniture22 = Furniture(context: furnitureContext)
            baseFurniture22.furnitureName = "Wooden coffee table"
            baseFurniture22.modelName = "wooden_coffee_table"
            baseFurniture22.category = "Tables"
            
            let baseFurniture23 = Furniture(context: furnitureContext)
            baseFurniture23.furnitureName = "Cover chair"
            baseFurniture23.modelName = "cover_chair"
            baseFurniture23.category = "Chairs"
            
            let baseFurniture24 = Furniture(context: furnitureContext)
            baseFurniture24.furnitureName = "Eastern carpet"
            baseFurniture24.modelName = "eastern_carpet"
            baseFurniture24.category = "Carpets"
            
            let baseFurniture25 = Furniture(context: furnitureContext)
            baseFurniture25.furnitureName = "Foyer table"
            baseFurniture25.modelName = "foyer_table"
            baseFurniture25.category = "Tables"
            
            let baseFurniture26 = Furniture(context: furnitureContext)
            baseFurniture26.furnitureName = "House plant"
            baseFurniture26.modelName = "house_plant"
            baseFurniture26.category = "Plants"
            
            let baseFurniture27 = Furniture(context: furnitureContext)
            baseFurniture27.furnitureName = "Vintage desk lamp"
            baseFurniture27.modelName = "vintage_desk_lamp"
            baseFurniture27.category = "Lamps"
            
            let baseFurniture28 = Furniture(context: furnitureContext)
            baseFurniture28.furnitureName = "Wooden wardrobe"
            baseFurniture28.modelName = "wooden_wardrobe"
            baseFurniture28.category = "Wardrobes"
            
            let baseFurniture29 = Furniture(context: furnitureContext)
            baseFurniture29.furnitureName = "Egg chair"
            baseFurniture29.modelName = "egg_chair"
            baseFurniture29.category = "Chairs"
            
            let baseFurniture30 = Furniture(context: furnitureContext)
            baseFurniture30.furnitureName = "Modern TV stand"
            baseFurniture30.modelName = "modern_tv_stand"
            baseFurniture30.category = "TV stands"
            
            let baseFurniture31 = Furniture(context: furnitureContext)
            baseFurniture31.furnitureName = "Poliform bed"
            baseFurniture31.modelName = "poliform_bed"
            baseFurniture31.category = "Beds"
            
            let baseFurniture32 = Furniture(context: furnitureContext)
            baseFurniture32.furnitureName = "Pool table"
            baseFurniture32.modelName = "pool_table"
            baseFurniture32.category = "Tables"
            
            let baseFurniture33 = Furniture(context: furnitureContext)
            baseFurniture33.furnitureName = "Simple chair"
            baseFurniture33.modelName = "simple_chair"
            baseFurniture33.category = "Chairs"
            
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
            
            let baseFurniture40 = Furniture(context: furnitureContext)
            baseFurniture40.furnitureName = "TV and stand"
            baseFurniture40.modelName = "tv_and_stand"
            baseFurniture40.category = "Stands"
            
            let baseFurniture41 = Furniture(context: furnitureContext)
            baseFurniture41.furnitureName = "Divan sofa"
            baseFurniture41.modelName = "divan_sofa"
            baseFurniture41.category = "Sofas"
            
            let baseFurniture42 = Furniture(context: furnitureContext)
            baseFurniture42.furnitureName = "Brownleather couch"
            baseFurniture42.modelName = "brownleather_couch"
            baseFurniture42.category = "Couches"
            
            let baseFurniture43 = Furniture(context: furnitureContext)
            baseFurniture43.furnitureName = "Wooden bed"
            baseFurniture43.modelName = "wooden_bed"
            baseFurniture43.category = "Beds"
            
            let baseFurniture44 = Furniture(context: furnitureContext)
            baseFurniture44.furnitureName = "Bed"
            baseFurniture44.modelName = "bed"
            baseFurniture44.category = "Beds"
            
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
/*
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            print("Täällä käytiin")
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
 */
}

