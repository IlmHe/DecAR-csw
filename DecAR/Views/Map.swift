//
//  Map.swift
//  DecAR
//
//  Created by iosdev on 4.12.2022.
//

import MapKit
import SwiftUI
import Foundation
import CoreLocation
import Combine

// TODO: Set the users current location as the initial location.
// TODO: Function which draws route to chosen annotation.
// TODO: Info bubbles for annotations when tapped.
// TODO: Button inside the info bubble to draw the route.
// TODO: UI changes for each team.

/**
 * ListingObject class
 * ListingObject can be given the values of a listing with added value coordinates.
 *
 * Main function.
 * @State var locations is used to capture all of the locations as ListingObject object.
 *  private var listings holds all of the fetched listings from the Core Data.
 * @State private var mapRegion holds predefined initial location as well as initial zoom distance.
 *
 * body
 * body contains MapKit map.
 * Annotations are drawn on the map and different types of UI stuff are done in it.
 *
 * .onAppear
 * Inside the maps .onAppear function is a for loop which loops through all of the fetched listings.
 * In every loop a geocoding function as well as completionHandler are called and given an address string from the current listing.
 * After the address has been forward geocoded it is captured in a newObject object which gets has the variables of ListingObject.
 * Finally the newObject is appended in the locations @State variable list which is used to draw the annotation to the map when the for loop is done.
 *
 * getCoordinate() function
 * getCoordinate() function geocodes given address string to coordinates of type CLLocationCoordinate2D and passes them to completionHandler which returns the coordinates asynchronously as well as error message which can be nil.
 * The function itself returns Void because it isn't asynchronous.
 *
 *
 * Note: To use completionHandler, you must give it the to be return value inside a function which returns Void. Then you call the function somewhere, give it some value and catch the return value as well as the error message from the completionHandler inside the function call.
 */

// Used to hold listing data.
class ListingObject: Identifiable {
  var id = UUID().uuidString
  var name: String = ""
  var address: String = ""
  var coordinate: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: 0, longitude: 0)
  
  init(name: String, address: String, coordinate: CLLocationCoordinate2D) {
    self.name = name
    self.address = address
    self.coordinate = coordinate
  }
}

struct MapView: View {
  //@State var location: CLLocationCoordinate2D?
  @State var locations: Array<ListingObject> = []
  
  // Fetches listings from the Core Data.
  @FetchRequest(
    sortDescriptors: [NSSortDescriptor(keyPath: \Listing.clientName, ascending: true)],
    animation: .default)
    
  // Holds all of the listing objects.
  private var listings: FetchedResults<Listing>
  
  // Sets initial location and zoom distance.
  @State private var mapRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 60.16952, longitude: 24.93545), span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2))
    
  var body: some View {
    // Map which shows all of the listings locations as pins.
    Map(coordinateRegion: $mapRegion, annotationItems: self.locations) { location in
      MapAnnotation(
        coordinate: location.coordinate,
        content: {
          Image(systemName: "pin.circle.fill").foregroundColor(.cyan)
          Text(location.name)
          onTapGesture {
            print("Tapped on: \(String(describing: location.name))")
          }
        }
      )
    }
    /*
     * Loops through all of the listings.
     * Calls the geocoder function which forward geocodes the given address string with completionHandler.
     * Makes a new object of type ListingObject and appends it to the locations @State variable list.
     * Returns the list of locations to Map function.
    */
    .onAppear {
      for address in listings {
        self.getCoordinate(addressString: address.clientAddress ?? "22 Sunset Ave, East Quogue, NY", completionHandler: { (coordinates, error) in
          let newObject = ListingObject(
            name: address.clientName!,
            address: address.clientAddress!,
            coordinate: coordinates
          )
          self.locations.append(newObject)
        })
      }
    }
  }
  
  /*
   * Needs to be given address string which this function geocodes to coordinates.
   * Gives coordinates to completionHandler.
   * completionHandler needs to be called inside the function call of this function to retrieve the geocoded coordinates as well as error message which can be nil.
   * Returns Void value.
  */
  func getCoordinate( addressString : String, completionHandler: @escaping(CLLocationCoordinate2D, NSError?) -> Void ) {
  let geocoder = CLGeocoder()
    geocoder.geocodeAddressString(addressString) { (placemarks, error) in
      if error == nil {
        if let placemark = placemarks?[0] {
          let location = placemark.location!
                    
          completionHandler(location.coordinate, nil)
          return
        }
      }
    }
  }
}
