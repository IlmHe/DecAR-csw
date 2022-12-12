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
            List {
                ForEach(furnitures) { furniture in
                    Button(furniture.furnitureName!, action: {
                        currentObject = SelectedFurniture( furniture.modelName!)
                        
                        let appFurniture = UserDefaults.standard
                        appFurniture.set(furniture.modelName, forKey: "AppCurrentObject")
     
                         isPresented = false
                    })
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
