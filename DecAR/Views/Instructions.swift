//
//  Instructions.swift
//  DecAR
//
//  Created by iosdev on 8.12.2022.
//

import Foundation
import SwiftUI

let Sections = NSLocalizedString("Sections", comment: "Sections")
let Section1 = NSLocalizedString("Section1", comment: "Section1")
let Section2 = NSLocalizedString("Section2", comment: "Section2")
let Section3 = NSLocalizedString("Section3", comment: "Section3")
let Section4 = NSLocalizedString("Section4", comment: "Section4")
let Section5 = NSLocalizedString("Section5", comment: "Section5")
let Section6 = NSLocalizedString("Section6", comment: "Section6")

struct InstructionsView: View {
  @State var locations: Array<ListingObject> = []
  
  var body: some View {
    ScrollView {
      VStack {
        Group {
          Spacer().frame(height: 25)
          Text("\(Sections)")
          .frame(maxWidth: .infinity, alignment: .leading)
          .padding(8)
          Spacer().frame(height: 25)
          Text("\(Section1)")
          .frame(maxWidth: .infinity, alignment: .leading)
          .padding(8)
          Spacer().frame(height: 25)
          Text("\(Section2)"
          )
          .frame(maxWidth: .infinity, alignment: .leading)
          .padding(8)
          Spacer().frame(height: 25)
        }
        
        Group {
          Text("\(Section3)")
          .frame(maxWidth: .infinity, alignment: .leading)
          .padding(8)
          Spacer().frame(height: 25)
          Text("\(Section4)")
          .frame(maxWidth: .infinity, alignment: .leading)
          .padding(8)
          Spacer().frame(height: 25)
          Text("\(Section5)")
          .frame(maxWidth: .infinity, alignment: .leading)
          .padding(8)
          Spacer().frame(height: 25)
          Text("\(Section6)")
          .frame(maxWidth: .infinity, alignment: .leading)
          .padding(8)
        }
      }
    }
  }
  
}
