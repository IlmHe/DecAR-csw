//
//  FurnitureMenu.swift
//  DecAR
//
//  Created by iosdev on 19.11.2022.
//

import SwiftUI

//Class stores selected furniture
class SelectedFurniture: Codable {
    var modelName: String
    var id = UUID().uuidString
    
    init(_ modelName: String) {
        self.modelName = modelName
    }
}

// Struct to store one category's data
struct Category: Identifiable {
    let id = UUID()
    let categoryName: String
}

// A view that shows data for one category
struct FurnitureCategoriesRow: View {
    var category: Category
    
    var body: some View {
       
            Text("\(category.categoryName)")
    }
}

//View shows furniture menu
struct FurnitureMenu: View {
    
   // var category: Category
    
    @Environment(\.managedObjectContext) private var viewContext
    
    let furnitureCategories = [Category(categoryName: "Chairs"), Category(categoryName: "Couches"), Category(categoryName: "Stools"), Category(categoryName: "Beds"), Category(categoryName: "Paintings"), Category(categoryName: "Lamps"),
                                                                                                                                                                                Category(categoryName: "Desks"), Category(categoryName: "Flower"), Category(categoryName: "Sculptures"), Category(categoryName: "Stands"), Category(categoryName: "Shelves"), Category(categoryName: "Carpet"), Category(categoryName: "Vases"), Category(categoryName: "Tableset"), Category(categoryName: "Mirrors"), Category(categoryName: "Tables"), Category(categoryName: "Plants"), Category(categoryName: "Wardrobes"), Category(categoryName: "Sets"), Category(categoryName: "Televisions"), Category(categoryName: "Pianos")]

    @Binding var isPresented: Bool
    
    @State private var currentId = 0
    @State var currentObject: SelectedFurniture = SelectedFurniture("stool")
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Furniture.furnitureName , ascending: true)],
        animation: .default)
    private var furnitures: FetchedResults<Furniture>
        
    var body: some View {
        
        VStack(alignment: .leading) {
            Button(action: {
                isPresented = false
            }) {
                Image(systemName: "arrow.backward")
                .resizable()
                .scaledToFit()
                .frame(width: 32, height: 32)
            }
            .padding(.leading, 30)
            .padding(.top, 10)
            
            
            Text("Furniture categories")
            NavigationView {
                List {
                    ForEach(furnitureCategories) {category in
                        NavigationLink {
                            List {
                            ForEach(furnitures) { furniture in
                                if("\(category.categoryName)"  == String?(furniture.category ?? "Chairs")!) {
                                    Button(furniture.furnitureName!, action: {
                                        currentObject = SelectedFurniture( furniture.modelName!)
                                        
                                        let appFurniture = UserDefaults.standard
                                        appFurniture.set(furniture.modelName, forKey: "AppCurrentObject")
                                        print("\(category.categoryName)")
                                        isPresented = false
                                    })
                                }
                            }
                        }
                        } label: {
                            FurnitureCategoriesRow(category: category)
                        }
                    }
                }
            }
            Spacer()
        }
        .frame(maxWidth: .infinity, alignment: .leading)
       // .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color(red: 64/255, green: 208/255, blue: 236/255))
        //.listStyle(.automatic)
        .listStyle(.sidebar)
        .edgesIgnoringSafeArea(.all)
    }
}

/*
List {
    ForEach(furnitures) { furniture in
        Button(furniture.furnitureName!, action: {
            currentObject = SelectedFurniture( furniture.modelName!)
            
            let appFurniture = UserDefaults.standard
            appFurniture.set(furniture.modelName, forKey: "AppCurrentObject")

             isPresented = false
        })
    }
        
}*/
