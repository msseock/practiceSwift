//
//  BookMapView.swift
//  PracticeMapKit
//
//  Created by 석민솔 on 6/6/24.
//

import SwiftUI
import MapKit

struct BookMapView: View {
    @StateObject private var bookMapVM = BookMapViewModel()
    
    var annotations : [Location] {
        return bookMapVM.locations
    }

    // MARK: - 뷰
    var body: some View {
        ZStack {
            mapLayer
                .ignoresSafeArea()
        }
    }
}

extension BookMapView {
    private var mapLayer: some View {
        Map(coordinateRegion: $bookMapVM.mapRegion,
            annotationItems: bookMapVM.locations,
            annotationContent: { location in
            MapAnnotation(coordinate: location.coordinates) {
                AnnotationView(type: location.locationType, isSelected: bookMapVM.selectedLocation == location)
                    .onTapGesture {
                        bookMapVM.showNextLocation(location: location)
                    }
            }
        })

    }
}
