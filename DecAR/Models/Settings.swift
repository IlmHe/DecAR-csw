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
                    alignment: .leading
                        ) {
                            Toggle("English 🇬🇧", isOn: $isOn).padding(80)
                        Spacer()
                        if isOn {
                            Text("testing")
                        }
                    }
                
            }
    }
}
struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        Settings()
    }
}
