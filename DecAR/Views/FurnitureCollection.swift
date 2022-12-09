//
//  FurnitureCollection.swift
//  DecAR
//
//  Created by iosdev on 23.11.2022.
//

import Foundation
import SwiftUI
import CoreData

let furnitureNameLoc = NSLocalizedString("furnitureName", comment: "furnitureName")
let furnitureAlertAddFurniture = NSLocalizedString("furnitureAlertAddFurniture", comment: "furnitureAlertAddFurniture")
let furnitureFurnitureName = NSLocalizedString("furnitureFurnitureName", comment: "furnitureFurnitureName")
let furnitureEnterFurnitureDetails = NSLocalizedString("furnitureEnterFurnitureDetails", comment: "furnitureEnterFurnitureDetails")
let furnitureSelectItem = NSLocalizedString("furnitureSelectItem", comment: "furnitureSelectItem")
let furnitureAddBtn = NSLocalizedString("listingsAddBtn", comment: "listingsAddBtn")
let furnitureCancelBtn = NSLocalizedString("listingsBtnCancel", comment: "listingsAddBtn")
let furniture3dModel = NSLocalizedString("furniture3dModel", comment: "furniture3dModel")
let furnitureCategory = NSLocalizedString("furnitureCategory", comment: "furnitureCategory")
let furnitureFurnitureCategory = NSLocalizedString("furnitureFurnitureCategory", comment: "furnitureFurnitureCategory")
let furniture3DModel = NSLocalizedString("furniture3DModel", comment: "furniture3DModel")






struct FurnitureCollectionView: View {
    @State private var presentAlert = false
    @State private var furnitureName: String = ""
    @State private var modelName: String = ""
    @State private var category: String = ""
    
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Furniture.furnitureName , ascending: true)],
        animation: .default)
    private var furnitures: FetchedResults<Furniture>

    var body: some View {
        NavigationView {
            List {
                ForEach(furnitures) { furniture in
                    NavigationLink {
                        Text("\(furnitureNameLoc) \(furniture.furnitureName!)")
                        Text("\(furniture3dModel) \(furniture.modelName!)")
                        Text("\(furnitureCategory) \(furniture.category!)")
                    } label: {
                        Text(furniture.furnitureName!)
                    }
                }
                .onDelete(perform: deleteItems)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
                ToolbarItem {
                        Button(furnitureAddBtn) {
                        presentAlert = true
                    }
                        .popover(isPresented: self.$presentAlert, arrowEdge: .bottom) {
                        Text(furnitureAlertAddFurniture)
                        TextField(furnitureFurnitureName, text: $furnitureName)
                        TextField(furnitureFurnitureCategory, text: $category)
                        TextField(furniture3DModel, text: $modelName)

                        Button(furnitureAddBtn, action: {
                            let newFurniture = Furniture(context: viewContext)
                            newFurniture.furnitureName = furnitureName
                            newFurniture.category = category
                            newFurniture.modelName = modelName

                            do {
                                try viewContext.save()
                                self.presentAlert = false
                            } catch {
                                let nsError = error as NSError
                                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
                            }
                        })
                            Button(listingsBtnCancel, action: {
                                self.presentAlert = false
                            })
                    }
                    }
            }
            Text(furnitureSelectItem)
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { furnitures[$0] }.forEach(viewContext.delete)
            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

struct FurnitureCollectionView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(currentObject: .constant(SelectedFurniture("stool"))).environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
