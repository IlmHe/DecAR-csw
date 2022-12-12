//
//  Menu.swift
//  DecAR
//
//  Created by iosdev on 19.11.2022.
//

import SwiftUI

let menuMapText:LocalizedStringKey = "menuMapText"
let menuSettingsText:LocalizedStringKey = "menuSettingsText"
let menuFurnitureText:LocalizedStringKey = "menuFurnitureText"
let menuListingsText:LocalizedStringKey = "menuListingsText"
let menuWeather:LocalizedStringKey = "menuWeather"

struct Menu: View {
    var body: some View {
        
        
        VStack(alignment: .leading) {
            HStack {

              NavigationLink(destination: MapView()) {
                    Image(systemName: "map")
                        .foregroundColor(Color(red: 102/255, green: 198/255, blue: 255/255))
                        .imageScale(.large)
                    Text(menuMapText)
                        .foregroundColor(.white)
                        .font(.headline)
                        .accessibilityLabel(menuMapText)
                }
            }
            .padding(.top, 100)
            HStack {

                NavigationLink(destination: InstructionsView()) {
                    Image(systemName: "questionmark.circle")
                        .foregroundColor(Color(red: 102/255, green: 198/255, blue: 255/255))
                        .imageScale(.large)
                    Text(menuSettingsText)
                        .foregroundColor(.white)
                        .font(.headline)
                        .accessibilityLabel(menuSettingsText)
                }
            }
            .padding(.top, 30)
            HStack {
                NavigationLink(destination: FurnitureCollectionView()) {
                    Image(systemName: "sofa.fill")
                        .foregroundColor(Color(red: 102/255, green: 198/255, blue: 255/255))
                        .imageScale(.large)
                    Text(menuFurnitureText)
                        .foregroundColor(.white)
                        .font(.headline)
                        .accessibilityLabel(menuFurnitureText)
                }
            }
            .padding(.top, 30)
            HStack {
                NavigationLink(destination: ListingsView()) {
                    Image(systemName: "list.bullet.clipboard.fill")
                        .foregroundColor(Color(red: 102/255, green: 198/255, blue: 255/255))
                        .imageScale(.large)
                    Text(menuListingsText)
                        .foregroundColor(.white)
                        .font(.headline)
                        .accessibilityLabel(menuListingsText)
                }
            }
            .padding(.top, 30)
            HStack {
                NavigationLink(destination: WeatherView()) {
                    Image(systemName: "cloud.sun.rain")
                        .foregroundColor(Color(red: 102/255, green: 198/255, blue: 255/255))
                        .imageScale(.large)
                    Text(menuWeather)
                        .foregroundColor(.white)
                        .font(.headline)
                        .accessibilityLabel(menuWeather)
                }
            }
            .padding(.top, 30)
           Spacer()
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color(red: 73/255, green: 167/255, blue: 221/255).opacity(0.1))
        .listStyle(.sidebar)
        .edgesIgnoringSafeArea(.all)
    }
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        Menu()
    }
}

