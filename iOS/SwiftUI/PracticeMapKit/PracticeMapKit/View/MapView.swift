//
//  MapView.swift
//  PracticeMapKit
//
//  Created by 석민솔 on 5/13/24.
//

import SwiftUI
import MapKit

struct MapView: UIViewRepresentable {
    
    @EnvironmentObject var mapData: MapViewModel
    
    func makeCoordinator() -> Coordinator {
        return MapView.Coordinator()
    }
    
    func makeUIView(context: Context) -> MKMapView {
        let view = mapData.mapView
        
        view.showsUserLocation = true
        view.delegate = context.coordinator
        
        return view
    }
    
    func updateUIView(_ uiView: MKMapView, context: Context) {
        
    }
    
    class Coordinator: NSObject, MKMapViewDelegate {
        
        func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
            
            // custom Pins...
            
            // Excluding User Blue Circle
            
            if annotation.isKind(of: MKUserLocation.self) { return nil }
            else {
                let pinAnnotaion = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "PIN_VIEW")
                pinAnnotaion.tintColor = .red
                pinAnnotaion.animatesDrop = true
                pinAnnotaion.canShowCallout = true
                
                return pinAnnotaion
            }
        }
    }
}
