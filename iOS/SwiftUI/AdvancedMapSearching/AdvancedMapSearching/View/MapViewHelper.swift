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
        return locationManager.mapView
    }
    
    func updateUIView(_ uiView: MKMapView, context: Context) {
        
    }
}
