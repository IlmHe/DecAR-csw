//
//  Settings.swift
//  DecAR
//
//  Created by iosdev on 20.11.2022.
//

import SwiftUI

struct Settings: View {
    @State var isOn = false
    var body: some View {
        ZStack(
            alignment: .top) {
                VStack(
                    alignment: .trailing
                        ) {
                            Toggle("English 🇬🇧", isOn: $isOn).padding(80)
                        Spacer()
                        if isOn {
                            Text("testing")
                        }
                    }
                        .padding()
                        .frame(maxWidth: .infinity, alignment: .trailing)
                        .background(Color(red: 64/255, green: 208/255, blue: 236/255))
                        .listStyle(.sidebar)
                        .edgesIgnoringSafeArea(.all)
            }
    }
}
struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        Settings()
    }
}
