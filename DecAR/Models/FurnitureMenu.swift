//
//  FurnitureMenu.swift
//  DecAR
//
//  Created by iosdev on 19.11.2022.
//

import SwiftUI

class SelectedFurniture: Codable {
    var modelName: String
    var id = UUID().uuidString
    
    init(_ modelName: String) {
        self.modelName = modelName
    }
    
}

struct FurnitureMenu: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    
    @State private var currentId = 0
    @State var currentObject: SelectedFurniture = SelectedFurniture("stool")
    
    @Binding var showFurMenu: Bool

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Furniture.furnitureName , ascending: true)],
        animation: .default)
    private var furnitures: FetchedResults<Furniture>
        
    var body: some View {
        VStack(alignment: .leading) {
            List {
                ForEach(furnitures) { furniture in
                    Button(furniture.furnitureName!, action: {
                        self.showFurMenu.toggle()
                            currentObject = SelectedFurniture( furniture.modelName!)
                            
                            if let encoded = try? JSONEncoder().encode(currentObject) {
                                UserDefaults.standard.set(encoded, forKey: "SelectedFurnitureCollection")
                            }
                            
                        })
                    }
                    //    Text(furniture.furnitureName!)
                    
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

struct FurnitureMenu_Previews: PreviewProvider {
    static var previews: some View {
        FurnitureMenu(showFurMenu: .constant(true))
    }
}
