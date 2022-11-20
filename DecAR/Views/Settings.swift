//
//  Settings.swift
//  DecAR
//
//  Created by iosdev on 20.11.2022.
//

import SwiftUI

struct SettingsView: View {
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
