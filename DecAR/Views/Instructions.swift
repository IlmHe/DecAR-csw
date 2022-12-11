//
//  Instructions.swift
//  DecAR
//
//  Created by iosdev on 8.12.2022.
//

import Foundation
import SwiftUI

struct InstructionsView: View {
  @State var locations: Array<ListingObject> = []

  @State var sections: Array<String> = [
    "These instructions are seperated to different sections:\n 1. Summary\n 2. VR view\n 3. Furniture view\n 4. Map\n 5. Listings list\n 6. Weather view",
    "**Section 1: Summary**\n You start up in our VR view where you can place the furniture around. You can change the apps language from top right of the VR screen. In the top left corner you can open up our navigation menu which you can use to move between the DecAR's views.",
    "**Section 2: VR View**\n In VR view you can choose and place different pieces of furniture by pressing the plus button. You can also tap the screen for 3 seconds to... and also douple tap to... .",
    "**Section 3: Furniture View**\n By hopping to furniture view from the navigation menu, you can add, edit as well as delete different pieces of furniture in DecAR.",
    "**Section 4: Map**\n In DecAR's map screen you'll see all of the listings on the map and in the future.",
    "**Section 5: Listings List**\n In listings list which you can get to from the menu you can add, edit and delete listings.\n **Important note!** Add the address to a listing in this form to show up correctly on the map:\n __'Address, Name of the province'__.",
    "**Section 6: Weather view**\n You can use our weather view to check the type of weather around the listing area by searching the name of the city where the next listing is located."]
  
  var body: some View {
    ScrollView {
      VStack {
        Group {
          Spacer()
          Text("These instructions are seperated to different sections:\n1. Summary\n2. VR view\n3. Furniture view\n4. Map\n5. Listings list\n6. Weather view"
          )
          Spacer()
          Text(
            "**Section 1: Summary**\nYou start up in our VR view where you can place the furniture around. You can change the apps language from top right of the VR screen. In the top left corner you can open up our navigation menu which you can use to move between the DecAR's views."
          )
          Spacer()
          // TODO: Edit
          Text(
            "**Section 2: VR View**\nIn VR view you can choose and place different pieces of furniture by pressing the plus button. You can also tap the screen for 3 seconds to... and also douple tap to... ."
          )
          Spacer()
        }
        Group {
          Text(
            "**Section 3: Furniture View**\nBy hopping to furniture view from the navigation menu, you can add, edit as well as delete different pieces of furniture in DecAR."
          )
          Spacer()
          // TODO: Edit
          Text(
            "**Section 4: Map**\nIn DecAR's map screen you'll see all of the listings on the map and in the future."
          )
          Spacer()
          Text(
            "**Section 5: Listings List**\nIn listings list which you can get to from the menu you can add, edit and delete listings.\n **Important note!** Add the address to a listing in this form to show up correctly on the map:\n __'Address, Name of the province'__."
          )
          Spacer()
          Text(
            "**Section 6: Weather view**\nYou can use our weather view to check the type of weather around the listing area by searching the name of the city where the next listing is located."
          )
        }
      }
    }
  }
  
}
