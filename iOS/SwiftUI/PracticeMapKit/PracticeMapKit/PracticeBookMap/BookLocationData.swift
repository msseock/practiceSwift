//
//  BookLocationData.swift
//  PracticeMapKit
//
//  Created by 석민솔 on 6/29/24.
//

import Foundation
import MapKit

class BookLocationData {
    static let locations: [Location] = [
        // 학교 근처
        Location(CLLocationCoordinate2D(latitude: 37.628000, longitude: 127.090230), .bookmark),
        Location(CLLocationCoordinate2D(latitude: 37.624777, longitude: 127.084938), .main),
        Location(CLLocationCoordinate2D(latitude: 37.637752, longitude: 127.078139), .bookmark),
        // 이탈리아 로마
        Location(CLLocationCoordinate2D(latitude: 41.8902, longitude: 12.4922), .main),
        Location(CLLocationCoordinate2D(latitude: 41.8986, longitude: 12.4769), .bookmark),
        Location(CLLocationCoordinate2D(latitude: 41.9009, longitude: 12.4833), .main)
    ]
}
