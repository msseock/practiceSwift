//
//  MapViewHelper.swift
//  AdvancedMapSearching
//
//  Created by 석민솔 on 7/1/24.
//

import SwiftUI
import MapKit

// MARK: UIKit MapView
struct MapViewHelper: UIViewRepresentable {
    @EnvironmentObject var locationManager: LocationManager

    func makeUIView(context: Context) -> MKMapView {
        context.coordinator.setupGesture(on: locationManager.mapView)
        return locationManager.mapView
    }
    
    func updateUIView(_ uiView: MKMapView, context: Context) { }

    func makeCoordinator() -> Coordinator {
        Coordinator(locationManager: locationManager)
    }
    
    class Coordinator: NSObject, UIGestureRecognizerDelegate {
        var locationManager: LocationManager
        
        init(locationManager: LocationManager) {
            self.locationManager = locationManager
        }
        
        func setupGesture(on mapView: MKMapView) {
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleMapTap(_:)))
            tapGesture.delegate = self
            mapView.addGestureRecognizer(tapGesture)
        }
        
        @objc func handleMapTap(_ gesture: UITapGestureRecognizer) {
            let location = gesture.location(in: gesture.view)
            if let mapView = gesture.view as? MKMapView {
                let coordinate = mapView.convert(location, toCoordinateFrom: mapView)
                locationManager.updateLocationAndPlacemark(coordinate: coordinate)
            }
        }
    }
}
