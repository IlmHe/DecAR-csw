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
   // @Binding var showFurMenu: Bool
    @Binding var isPresented: Bool
    @State private var currentId = 0
    @State var currentObject: SelectedFurniture = SelectedFurniture("stool")
    
    //@Binding var showFurMenu: Bool

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Furniture.furnitureName , ascending: true)],
        animation: .default)
    private var furnitures: FetchedResults<Furniture>
        
    var body: some View {
        VStack(alignment: .leading) {
            Button("Dismiss") {
                isPresented = false
            }
            List {
                ForEach(furnitures) { furniture in
                    Button(furniture.furnitureName!, action: {
                      //  self.showFurMenu.toggle()
                            currentObject = SelectedFurniture( furniture.modelName!)
                        print("Current OBJECT \(currentObject.modelName)")
                        let appFurniture = UserDefaults.standard
                        appFurniture.set(furniture.modelName, forKey: "AppCurrentObject")
                        do {
                            let encoder = JSONEncoder()
                            let dataFurniture = try? encoder.encode(currentObject)
                            UserDefaults.standard.set(dataFurniture, forKey: "SelectedFurnitureCollection")
                        } catch {
                            print("Encode not working dataFurniture")
                        }
                        /*
                        if let dataFur = UserDefaults.standard.data(forKey: "SelectedFurnitureCollection") {
                            do {
                                let decoder = JSONDecoder()

                                let getSavedFur = try decoder.decode(SelectedFurniture.self, from: dataFur)
                                print("Printtaaa jo \(getSavedFur.modelName)")
                            } catch {
                                print("Unable to Decode dataFurniture")
                            }
                        }
                         */
                        //    if let encoded = try? JSONEncoder().encode(currentObject) {
                        /*
                        if let encoded = try? JSONEncoder().encode(currentObject) {
                        let toSaveFur = UserDefaults.standard.set(encoded, forKey: "SelectedFurnitureCollection")
                            print("EEENNNCOODE \(toSaveFur)")
                            }
                          
                        if let data = UserDefaults.standard.object(forKey: "SelectedFurnitureCollection") as? Data {
                            
                            let selectedFurnitures = try? JSONDecoder().decode([SelectedFurniture].self, from: data)
                            let newFurniture = selectedFurnitures
                            print("Decoded furniture \(newFurniture)")
                        }
*/
                 //   Button(furniture.furnitureName!){
                    //    let selectedItem = SelectedFurniture(modelName: furniture.modelName!, id: currentId)
                        print("Toimiko objektin luonti \(currentObject)")
                        //currentId += 1
                        print("Toimiko id korotus \(currentId)")
                      // showFurMenu = false
                         isPresented = false
                      //  let savedFurniture = UserDefaults.standard
                      //  let savedFurArray = [selectedItem]
                      //  savedFurniture.set(savedFurArray, forKey: "SavedFurnituteCollection")
                      //  let getSavedArray = savedFurniture.array(forKey: "SavedFurnitureCollection")
                      //  let getSavedArray = defaults.object(forKey: "SavedFurnitureCollection") as? [String] ?? [String]()
                       // showFurMenu = false
                      //  ContentView()

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
/*
struct FurnitureMenu_Previews: PreviewProvider {
    static var previews: some View {
<<<<<<< Updated upstream
        FurnitureMenu(showFurMenu: .constant(true))
=======
//        FurnitureMenu()
>>>>>>> Stashed changes
    }
}
*/
