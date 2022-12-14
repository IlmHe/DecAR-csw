//
//  Menu.swift
//  DecAR
//
//  Created by iosdev on 19.11.2022.
//

import SwiftUI
import MapKit
import Foundation
import CoreLocation
import Combine

let menuMapText:LocalizedStringKey = "menuMapText"
let menuSettingsText:LocalizedStringKey = "menuSettingsText"
let menuFurnitureText:LocalizedStringKey = "menuFurnitureText"
let menuListingsText:LocalizedStringKey = "menuListingsText"


struct Menu: View {
    var body: some View {
        VStack(alignment: .leading) {
            HStack {

              NavigationLink(destination: MapView()) {
                    Image(systemName: "map")
                        .foregroundColor(.gray)
                        .imageScale(.large)
                    Text(menuMapText)
                            .foregroundColor(.gray)
                            .font(.headline)
                }
            }
            .padding(.top, 100)
            HStack {

                NavigationLink(destination: Settings()) {
                    Image(systemName: "gear")
                        .foregroundColor(.gray)
                        .imageScale(.large)
                    Text(menuSettingsText)
                        .foregroundColor(.gray)
                        .font(.headline)
                }
            }
            .padding(.top, 30)
            HStack {
                NavigationLink(destination: FurnitureCollectionView()) {
                    Image(systemName: "map")
                        .foregroundColor(.gray)
                        .imageScale(.large)
                    Text(menuFurnitureText)
                        .foregroundColor(.gray)
                        .font(.headline)
                }
            }
            .padding(.top, 30)
            HStack {
                NavigationLink(destination: ListingsView()) {
                    Image(systemName: "map")
                        .foregroundColor(.gray)
                        .imageScale(.large)
                    Text(menuListingsText)
                        .foregroundColor(.gray)
                        .font(.headline)
                }
            }
            .padding(.top, 30)
            Spacer()
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color(red: 64/255, green: 208/255, blue: 236/255).opacity(0.1))
        .listStyle(.sidebar)
        .edgesIgnoringSafeArea(.all)
    }
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        Menu()
    }
}

