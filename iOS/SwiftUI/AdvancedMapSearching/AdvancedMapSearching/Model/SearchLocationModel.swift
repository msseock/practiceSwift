//
//  SearchLocationModel.swift
//  AdvancedMapSearching
//
//  Created by 석민솔 on 7/1/24.
//

//import Foundation
import MapKit

struct recentlySearchedLocation: Identifiable {
    let placeName: String
    let address: String
    let coordinate: CLLocationCoordinate2D
    
    var id: String {
        self.placeName
    }
}
