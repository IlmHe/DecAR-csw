//
//  FurnitureMenu.swift
//  DecAR
//
//  Created by iosdev on 19.11.2022.
//

import SwiftUI

struct FurnitureMenu: View {
    var body: some View {
        VStack(alignment: .leading) {
            
            Spacer()
        }
        .frame(maxWidth: .infinity, alignment: .bottom)
        .background(Color(red: 64/255, green: 208/255, blue: 236/255))
        .listStyle(.automatic)
        .edgesIgnoringSafeArea(.all)
    }
}

struct FurnitureMenu_Previews: PreviewProvider {
    static var previews: some View {
        FurnitureMenu()
    }
}
