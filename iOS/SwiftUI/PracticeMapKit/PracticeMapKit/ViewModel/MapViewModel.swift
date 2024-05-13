//
//  MapViewModel.swift
//  PracticeMapKit
//
//  Created by 석민솔 on 5/14/24.
//

import SwiftUI
import MapKit
import CoreLocation

// All Map Data Goes Here

class MapViewModel: NSObject, ObservableObject, CLLocationManagerDelegate {
    @Published var mapView = MKMapView()
    
    // Region...
    @Published var region: MKCoordinateRegion!
    // Based on Location It Will Set up...
    
    // Alert...
    @Published var permissionDenied = false
    
    // Focus Location...
    func focusLocation() {
        guard let _ = region else {return}
        
        mapView.setRegion(region, animated: true)
        mapView.setVisibleMapRect(mapView.visibleMapRect, animated: true)
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        // Checking Permissions...
        switch manager.authorizationStatus {
        case .denied:
            // Alert...
            permissionDenied.toggle()
        case .notDetermined:
            // Requesting
            manager.requestWhenInUseAuthorization()
        case .authorizedWhenInUse:
            // If Permission Given
            manager.requestLocation()
        default:
            ()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: any Error) {
        // Error...
        print(error.localizedDescription)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else {return}
        
        self.region = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: 10000, longitudinalMeters: 10000)
        
        // Updating Map....
        self.mapView.setRegion(self.region, animated: true)
        
        // Smooth Animations...
        self.mapView.setVisibleMapRect(self.mapView.visibleMapRect, animated: true)
    }
}
