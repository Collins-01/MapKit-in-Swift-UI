//
//  content_viewmodel.swift
//  MapKit in Swift UI
//
//  Created by Oriakhi Collins on 4/3/22.
//

import Foundation
import MapKit


final class ContentViewModel: NSObject, ObservableObject , CLLocationManagerDelegate{
    
    @Published  var region = MKCoordinateRegion(center : MapDetails.initialLocation, span: MapDetails.defaultSpan)
    var clLocationManager:CLLocationManager?
    
    //    A function to check if the user location permission has beeen enabled
    func checkLocationServiceEnabled() {
        if CLLocationManager.locationServicesEnabled() {
            clLocationManager = CLLocationManager()
            clLocationManager?.desiredAccuracy = kCLLocationAccuracyBest
            clLocationManager!.delegate = self
        }
        else{
            print("Show an alert letting the user know to accept permission")
        }
    }
    
    //    Check Location Authoizarion
    func checkLocationAuthorization() {
        guard let locationManager = clLocationManager else {
            return
        }
        print(locationManager)
        switch locationManager.authorizationStatus {
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
            
        case .denied:
            print("You have denied this application, pemission to your location")
            
        case .restricted :
            print("Your Location is restricted, due to parental control")
        case .authorizedAlways, .authorizedWhenInUse:
            region = MKCoordinateRegion(center: locationManager.location!.coordinate, span: MapDetails.defaultSpan)
            break
            
        @unknown  default:
            break
        }
    }
    
    //    check when the authorization statsus chnages
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkLocationAuthorization()
    }
    
    
  
}


enum MapDetails {
    static let initialLocation = CLLocationCoordinate2D(latitude: 37.55555, longitude: -121.9476764)
    
    static let defaultSpan = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
}
