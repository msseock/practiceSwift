//
//  LocationManager.swift
//  AdvancedMapSearching
//
//  Created by 석민솔 on 6/30/24.
//

import SwiftUI
import CoreLocation
import MapKit
// MARK: Combine Framework to watch Textfield Change
import Combine

class LocationManager: NSObject, ObservableObject, MKMapViewDelegate, CLLocationManagerDelegate {
    // MARK: Properties
    @Published var mapView: MKMapView = .init()
    @Published var manager: CLLocationManager = .init()
    
    // MARK: Search Bar Text
    @Published var searchText: String = ""
    var cancellable: AnyCancellable?
    @Published var fetchedPlaces: [CLPlacemark]?
    
    // MARK: User Location
    @Published var userLocation: CLLocation?
    
    // MARK: Final Location
    @Published var pickedLocation: CLLocation?
    @Published var pickedPlaceMark: CLPlacemark?
    
    
    override init() {
        super.init()
        // MARK: Setting Delegates
        manager.delegate = self
        mapView.delegate = self
        
        // MARK: Requesting Location Access
        manager.requestWhenInUseAuthorization()
        
        // MARK: Search Textfield Watching
        cancellable = $searchText
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
            .removeDuplicates()
            .sink(receiveValue: { value in
                if value != "" {
                    self.fetchPlaces(value: value)
                } else {
                    self.fetchedPlaces = nil
                }
            })
    }
    
    func fetchPlaces(value: String) {
        // MARK: Fetching places using MKLocalSearch & Async/Await
        Task {
            do {
                let request = MKLocalSearch.Request()
                request.naturalLanguageQuery = value.lowercased()
                
                let response = try await MKLocalSearch(request: request).start()
                // We can also Use Mainactor To publish changes in Main Thread
                await MainActor.run {
                    self.fetchedPlaces = response.mapItems.compactMap({ item -> CLPlacemark? in
                        return item.placemark
                    })
                }
            } catch {
                 // Handle Error
            }
        }
        print(value)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: any Error) {
        // Handle error
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let currentLocation = locations.last else {
            print("유저 현재위치 못구함")
            return
        }
        self.userLocation = currentLocation
        print("유저 위치 구함!")
    }
    
    // MARK: Location Authorization
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .authorizedAlways: manager.requestLocation()
        case .authorizedWhenInUse: manager.requestLocation()
        case .denied: handleLocationError()
        case .notDetermined: manager.requestWhenInUseAuthorization()
        default: ()
        }
    }
    
    func handleLocationError() {
        // Handle error
    }
    
    // MARK: Add Pin to MapView
    func addPin(at coordinate: CLLocationCoordinate2D) {
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        mapView.addAnnotation(annotation)
    }
    
    // MARK: Annotation 위치 표시
    func mapView(_ mapView: MKMapView, viewFor annotation: any MKAnnotation) -> MKAnnotationView? {
        let marker = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: "DELIVERYPIN")
        marker.canShowCallout = false
        
        return marker
    }
    
    // MARK: Update location by tapping on the map
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        guard let tappedLocatioin = view.annotation?.coordinate else { return }
        
        // Update the picked location
        self.pickedLocation = CLLocation(latitude: tappedLocatioin.latitude, longitude: tappedLocatioin.longitude)
        
        // Clear existing annotations and add a new one
        mapView.removeAnnotations(mapView.annotations)
        addPin(at: tappedLocatioin)
        
        // Update placemark for the new location
        updatePlacemark(location: CLLocation(latitude: tappedLocatioin.latitude, longitude: tappedLocatioin.longitude))
        
    }
    
    
    func updatePlacemark(location: CLLocation) {
        Task {
            do {
                guard let place = try await reverseLocationCoordinates(location: location) else { return }
                await MainActor.run {
                    self.pickedPlaceMark = place
                }
            } catch {
                // handle error
            }
        }
    }
    
    func updateLocationAndPlacemark(coordinate: CLLocationCoordinate2D) {
        self.pickedLocation = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
        mapView.removeAnnotations(mapView.annotations)
        addPin(at: coordinate)
        updatePlacemark(location: CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude))
    }

    
    // MARK: Displaying New Location Data
    func reverseLocationCoordinates(location: CLLocation) async throws->CLPlacemark? {
        let place = try await CLGeocoder().reverseGeocodeLocation(location).first
        return place
    }
}
