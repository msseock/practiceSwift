//
//  BookMapModel.swift
//  PracticeMapKit
//
//  Created by 석민솔 on 6/6/24.
//

import SwiftUI
import MapKit

struct LocationInfo {
    /// 위경도 정보
    let location: CLLocationCoordinate2D
    /// 대표위치/책갈피위치
    let locationType: LocationType
    /// 위치정보 입력한 날짜
    let date: String
    /// 책제목
    let title: String
    /// (책갈피위치만) 기록된 페이지
    let readPage: Int
}

class SingleAnnotation: ObservableObject, Identifiable {
    let id: Int
    let locationInfo: LocationInfo
    @Published var isActive: Bool
    
    private static var nextID = 0
    
    init(_ locationInfo: LocationInfo) {
        self.id = SingleAnnotation.nextID
        self.locationInfo = locationInfo
        self.isActive = false
        SingleAnnotation.nextID += 1
    }
}

enum LocationType {
    case main
    case bookmark
}
