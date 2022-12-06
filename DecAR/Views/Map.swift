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


struct ListingObject {
  var id = UUID().uuidString
  var name: String = ""
  var address: String = ""
  var coordinate: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: 0, longitude: 0)
}

struct MapView: View {
  //var listingObject: ListingObject
  @State var newListing: ListingObject = ListingObject()
  @State var listingList: [ListingObject] = []
  
  @FetchRequest(
    sortDescriptors: [NSSortDescriptor(keyPath: \Listing.clientName, ascending: true)],
    animation: .default)
  
  // Holds all of the listing objects.
  private var listings: FetchedResults<Listing>
  
  @State private var mapRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 60.16952, longitude: 24.93545), span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2))
  
  /*
  let listingsHC = [
    MapListingObject(
      name: "Paikka 1",
      info: "hieno paikka",
      addressName: "this is address",
      coordinate: CLLocationCoordinate2D(latitude: 60, longitude: 25)),
    MapListingObject(
      name: "Paikka 2",
      info: "jännä paikka",
      addressName: "this is address",
      coordinate: CLLocationCoordinate2D(latitude: 61, longitude: 26))
  ]
   */
  
  /*
  func listingsLoop() -> Void {
    for (listing) in listings{
      getCoordinate(addressString: listing.clientAddress ?? "Rastaspuistontie 3") { geocodedCoordinates, error in
        print("geocode print: ", geocodedCoordinates)
      }
    }
    return
  }
   */
  
  var body: some View {
  /*
   getCoordinate(addressString: listing.clientAddress ?? "Rastaspuistontie 3",
      completionHandler: {
      (geocodedCoordinates: CLLocationCoordinate2D, error) -> CLLocationCoordinate2D in
      if error === nil {
        coordinates = geocodedCoordinates
      }
   }
   */
    
    /*
    ForEach(listings) { listing in
      listingList.append(voidCheck(listing))
    */
    
    ZStack {
      Map(coordinateRegion: $mapRegion,
        annotationItems: listingList)
        { listing in
        
       // let coordinate: CLLocationCoordinate2D = getCoordinate(addressString: listing.clientAddress)
        
          MapAnnotation(
            coordinate: listing.coordinate,
            content: {
              Image(systemName: "pin.circle.fill").foregroundColor(.cyan)
              Text(listing.name ?? "No name")
              onTapGesture {
                print("Tapped on: \(String(describing: listing.name))")
                // TODO: Other UI implementations when tapping the annotation.
              }
            }
          )
        }
    }.onAppear()
  }
  
/*
    var body: some View {
      
      ZStack {
        Map(coordinateRegion: $mapRegion,
         annotationItems: listings)
         { listing in
           MapAnnotation(
            coordinate: listing.coordinate,
            content: {
              Image(systemName: "pin.circle.fill").foregroundColor(.cyan)
              Text(listing.name ?? "No name")
              onTapGesture {
               print("Tapped on: \(String(describing: listing.name))")
               // TODO: Other UI implementations when tapping the annotation.
             }
           })
          }
        }
      }
 */
  
  // Checks if the getCoordinate function returned void
  /*func voidCheck(listing: Listing) -> ListingObject {
      makeListingObjects(listing: Listing) { listing in
        guard newListing.coordinate != Void else {
              return
          }
        return newListing
          //Use `username` here...
          //...
      }
  }
   */
  
  // Makes object out of fetched core data and creates coordinate out of fetched address
  func makeListingObjects(listing: Listing) -> ListingObject {
    newListing.name = listing.clientName ?? ""
    newListing.address = listing.clientAddress ?? ""
    newListing.coordinate = getCoordinate(addressString: newListing.address ?? "Mannerheimintie 7") { (coordinate2d, error) in
      return coordinate2d
    }
    return newListing
  }
    
  
   
  // geocoding func 1
  func getCoordinate( addressString : String,
                      completionHandler: @escaping(CLLocationCoordinate2D, NSError?) -> Void ) {
    let geocoder = CLGeocoder()
    geocoder.geocodeAddressString(addressString) { (placemarks, error) in
      if error == nil {
        if let placemark = placemarks?[0] {
          let location = placemark.location!
          
          completionHandler(location.coordinate, nil)
          return
        }
      }
      completionHandler(kCLLocationCoordinate2DInvalid, error as NSError?)
    }
  }
}
  

/*
 // geocoding func 2
 func addressToCoordinates(forAddress address: String, completion: @escaping (CLLocationCoordinate2D?) -> Void) {
 let geocoder = CLGeocoder()
 geocoder.geocodeAddressString(address) {
 (placemarks, error) in
 guard error == nil else {
 print("Geocoding error: \(error!)")
 completion(nil)
 return
 }
 completion(placemarks?.first?.location?.coordinate)
 }
 }
 }*/


  /*
   class LocationManager : ObservableObject {
   @Published var location : CLLocationCoordinate2D?
   
   func convertAddress(address: String) {
   getCoordinate(addressString: address) { (location, error) in
   if error != nil {
   //handle error
   return
   }
   DispatchQueue.main.async {
   self.location = location
   }
   }
   }
   
   private func getCoordinate(addressString : String,
   completionHandler: @escaping(CLLocationCoordinate2D, NSError?) -> Void ) {
   let geocoder = CLGeocoder()
   geocoder.geocodeAddressString(addressString) { (placemarks, error) in
   if error == nil {
   if let placemark = placemarks?[0] {
   let location = placemark.location!
   
   completionHandler(location.coordinate, nil)
   return
   }
   }
   
   completionHandler(kCLLocationCoordinate2DInvalid, error as NSError?)
   }
   }
   }
   */
  
  /*
   class LocationManager: NSObject, ObservableObject {
   
   private let geocoder = CLGeocoder()
   private let locationManager = CLLocationManager()
   let objectWillChange = PassthroughSubject<Void, Never>()
   
   @Published var status: CLAuthorizationStatus? {
   willSet { objectWillChange.send() }
   }
   
   @Published var location: CLLocation? {
   willSet { objectWillChange.send() }
   }
   
   override init() {
   super.init()
   
   self.locationManager.delegate = self
   self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
   self.locationManager.requestWhenInUseAuthorization()
   self.locationManager.startUpdatingLocation()
   }
   
   
   @Published var placemark: CLPlacemark? {
   willSet { objectWillChange.send() }
   }
   
   private func geocode() {
   guard let location = self.placemark?.location else { return }
   geocoder.reverseGeocodeLocation(location, completionHandler: { (places, error) in
   if error == nil {
   self.placemark = places?[0]
   } else {
   self.placemark = nil
   }
   })
   }
   }
   
   extension CLLocation {
   var latitude: Double {
   return self.coordinate.latitude
   }
   
   var longitude: Double {
   return self.coordinate.longitude
   }
   }
   */
  
  
  /*
   override func viewDidLoad() {
   super.viewDidLoad()
   
   // Sets the initial location to Helsinki
   let initialLocation = CLLocation(latitude: 60.16952, longitude: 24.93545)
   mapView.centerToLocation(initialLocation)
   
   // Sets the min and max ranges to zoom in map
   let zoomRange = MKMapView.CameraZoomRange(maxCenterCoordinateDistance: 200000)
   mapView.setCameraZoomRange(zoomRange, animated: true)
   
   // Sets ViewController the delegate of the map view
   mapView.delegate = self
   }
   }
   
   
   private extension MKMapView {
   func centerToLocation(
   _ location: CLLocation,
   regionRadius: CLLocationDistance = 1000
   ) {
   let coordinateRegion = MKCoordinateRegion(
   center: location.coordinate,
   latitudinalMeters: regionRadius,
   longitudinalMeters: regionRadius)
   setRegion(coordinateRegion, animated: true)
   }
   }
   
   
   
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
