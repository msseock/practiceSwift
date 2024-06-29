//
//  BookMapViewModel.swift
//  PracticeMapKit
//
//  Created by 석민솔 on 6/7/24.
//

import Foundation
import MapKit
import SwiftUI


class BookMapViewModel: ObservableObject {
    // 모든 위치 정보 배열
    @Published var locations: [Location] = []
    
    // 현재 강조되는 한 개 위치
    @Published var selectedLocation: Location {
        didSet {
            updateMapRegion(location: selectedLocation)
        }
    }
    
    @Published var mapRegion: MKCoordinateRegion = MKCoordinateRegion()
    
    init() {
        let locations = BookLocationData.locations
        self.locations = locations
        self.selectedLocation = locations.first!
        
        self.mapRegion = MKCoordinateRegion(center: locations.first!.coordinates,
                                             span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))
    }
    
    private func updateMapRegion(location: Location) {
        withAnimation(.easeInOut) {
            mapRegion = MKCoordinateRegion(
                center: location.coordinates,
                span: mapRegion.span)
        }
    }
    
    func showNextLocation(location: Location) {
        withAnimation(.easeInOut) {
            selectedLocation = location
        }
    }

    
    // 선택한 것 제외한 annotation 모두 비활성화시키기
//    func deactivateAllExcept(_ activeAnnotation: Location) {
//        for annotation in items {
//            if annotation.id != activeAnnotation.id {
//                annotation.isActive = false
//            }
//        }
//    }
    
    
//    func deactivateAllExcept(_ activeAnnotation: Location) {
//        for annotation in items {
//            if annotation.id != activeAnnotation.id {
//                annotation.deactivate()
//            } else {
//                annotation.activate()
//            }
//        }
//    }
}
