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
    
    // SearchText
    @Published var searchTxt = ""
    
    // Searched Places...
    @Published var places : [Place] = []
    
    // Focus Location...
    func focusLocation() {
        guard let _ = region else {return}
        
        mapView.setRegion(region, animated: true)
        mapView.setVisibleMapRect(mapView.visibleMapRect, animated: true)
    }
    
    // Search Places...
    func searchQuery() {
        
        places.removeAll()
        
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = searchTxt
        
        // Fetch...
        MKLocalSearch(request: request).start { (response, _) in
            guard let result = response else { return }
            
            self.places = result.mapItems.compactMap({ (item) -> Place? in
                return Place(place: item.placemark)
            })
        }
    }
    
    // Pick Search Result
    func selectPlace(place: Place) {
        
        // Showing Pin On Map
        searchTxt = ""
        guard let coordinate = place.place.location?.coordinate else { return }
        
//        // 정보 출력해보기
//        print("locality:", place.place.locality ?? "모름")
//        print("subLocality:", place.place.subLocality ?? "모름")
//        print("thoroughfare:", place.place.thoroughfare ?? "모름")
//        print("subThoroughfare:", place.place.subThoroughfare ?? "모름")
//        print("region:", place.place.region ?? "모름")
//        print("postalCode:", place.place.postalCode ?? "모름")
        
        let pointAnnotation = MKPointAnnotation()
        pointAnnotation.coordinate = coordinate
        pointAnnotation.title = place.place.name ?? "No Name"
        
        // Removing All Old Ones...
        mapView.removeAnnotations(mapView.annotations)
        
        mapView.addAnnotation(pointAnnotation)
        
        // Move Map To That Location...
        let coordinateRegion = MKCoordinateRegion(center: coordinate, latitudinalMeters: 500, longitudinalMeters: 500)
        
        mapView.setRegion(coordinateRegion, animated: true)
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
