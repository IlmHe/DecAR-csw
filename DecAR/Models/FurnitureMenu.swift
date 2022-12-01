//
//  FurnitureMenu.swift
//  DecAR
//
//  Created by iosdev on 19.11.2022.
//

import SwiftUI

class SelectedFurniture {
    var modelName: String
    var id: Int = 0
    
    init(modelName: String, id: Int) {
        self.modelName = modelName
        self.id = id
    }
}

struct FurnitureMenu: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    
    @State private var currentId = 0

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Furniture.furnitureName , ascending: true)],
        animation: .default)
    private var furnitures: FetchedResults<Furniture>
    
    var body: some View {
        VStack(alignment: .leading) {
            List {
                ForEach(furnitures) { furniture in
                    Button(furniture.furnitureName!){
                        let selectedItem = SelectedFurniture(modelName: furniture.modelName!, id: currentId)
                        print("Toimiko objektin luonti \(selectedItem.modelName)")
                        currentId += 1
                        print("Toimiko id korotus \(currentId)")

                    }
                    //    Text(furniture.furnitureName!)
                    
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

struct FurnitureMenu_Previews: PreviewProvider {
    static var previews: some View {
        FurnitureMenu()
    }
}
