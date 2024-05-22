//
//  Place.swift
//  PracticeMapKit
//
//  Created by 석민솔 on 5/22/24.
//

import SwiftUI
import MapKit

struct Place: Identifiable {
    
    var id = UUID().uuidString
    
    var place: CLPlacemark
    
    var address: String {
        var address = ""
        
        if let locality = place.locality {
            address += locality + " "
            print("address1: ", address)
        }
        
        if let subLocality = place.subLocality {
            address += subLocality + " "
            print("address2: ", address)
        }
        
        if let thoroughfare = place.thoroughfare {
            address += thoroughfare + " "
            print("address3: ", address)
        }
        
        return address
        
    }
}
