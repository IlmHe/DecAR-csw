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

let mapNoName = NSLocalizedString("mapNoName", comment: "mapNoName")
let mapTapped = NSLocalizedString("mapTapped", comment: "mapTapped")



// Placeholder listings
let listings = [
  MapListingObject(
    name: "Listing 1",
    addressName: "Yrjönkatu",
    coordinate: CLLocationCoordinate2D(latitude: 60.16746134802547, longitude: 24.93970899959051)),
  MapListingObject(
    name: "Listing 2",
    addressName: "Iskoskuja 3b",
    coordinate: CLLocationCoordinate2D(latitude: 60.26103259739199, longitude: 24.854346179663626)),
  MapListingObject(
    name: "Listing 3",
    addressName: "Mannerheimintie",
    coordinate: CLLocationCoordinate2D(latitude: 60.16762883994775, longitude: 24.9414360241139)),
  MapListingObject(
    name: "Listing 4",
    addressName: "Kalevankatu",
    coordinate: CLLocationCoordinate2D(latitude: 60.1671440962688, longitude: 24.937641323263826)),
  MapListingObject(
    name: "Listing 5",
    addressName: "Yrjönkatu",
    coordinate: CLLocationCoordinate2D(latitude: 60.16834348288605, longitude: 24.93722274756878)),
  MapListingObject(
    name: "Listing 6",
    addressName: "Simonkatu",
    coordinate: CLLocationCoordinate2D(latitude: 60.169115888388546, longitude: 24.936644432016113)),
  MapListingObject(
    name: "Listing 7",
    addressName: "Kaivokatu",
    coordinate: CLLocationCoordinate2D(latitude: 60.170160183289305, longitude: 24.938878472998844)),
  MapListingObject(
    name: "Listing 8",
    addressName: "Postikuja",
    coordinate: CLLocationCoordinate2D(latitude: 60.17153938982138, longitude: 24.937397034438387)),
  MapListingObject(
    name: "Listing 9",
    addressName: "Töölönlahdenkatu",
    coordinate: CLLocationCoordinate2D(latitude: 60.172628922037795, longitude: 24.938565548775284)),
  MapListingObject(
    name: "Listing 10",
    addressName: "Kaisaniemenkatu",
    coordinate: CLLocationCoordinate2D(latitude: 60.171252738559694, longitude: 24.94724923230181)),
]

struct MapListingObject: Identifiable {
  var id = UUID()
  var name: String?
  var addressName: String?
  @State var coordinate: CLLocationCoordinate2D
}

struct MapView: View {
  
  // Sets the initial location to Helsinki and initial zoom distance to 0.5.
  @State private var mapRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 60.16952, longitude: 24.93545), span: MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02))
  
  var body: some View {
    
    ZStack {
      Map(coordinateRegion: $mapRegion,
       annotationItems: listings)
       { listing in
         MapAnnotation(
          coordinate: listing.coordinate,
          content: {
            Image(systemName: "pin.circle.fill").foregroundColor(.cyan)
            Text(listing.name ?? mapNoName)
            onTapGesture {
             print("\(mapTapped) \(String(describing: listing.name))")
             // TODO: Other UI implementations when tapping the annotation.
           }
         })
        }
      }
    }
  }
//}
 
/*
   extension MapView: MKMapViewDelegate {
   
   /**
    *This function launches Maps app and shows driving directions from user's current location to location which was tapped.
    * -----------------------------------------
    *1. When user taps the 'info' button on listings description iOS calls mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped...)
    *2. You check something like if there is a location in the Listing object which was tapped on the guard function if not it returns NIL I guess.
    *3. You grab the Listing object and launch Maps app by creating an associated MKMapItem and calling openInMaps(launchOptions:) on the map item.
    *Notice that you create launchOptions variable in which you define the Maps app to show directions in driving mode.
    *You use this launchOptions variable when launching the Maps app.
    */
   func mapView(
   // 1
   _ mapView: MKMapView,
   annotationView view: MKAnnotationView,
   calloutAccessoryControlTapped control: UIControl
   ) {
   // 2
   guard let listingObject = view.annotation as? MapListingObject else {
   return
   }
   
   // 3
   let launchOptions = [
   MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving
   ]
   listingObject.addressName?.openInMaps(launchOptions: launchOptions)
   }
   }
   
   
   */
