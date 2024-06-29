//
//  BookMapModel.swift
//  PracticeMapKit
//
//  Created by 석민솔 on 6/6/24.
//

import SwiftUI
import MapKit
import Combine

//struct LocationInfo {
//    /// 위경도 정보
//    let coordinates: CLLocationCoordinate2D
//    /// 대표위치/책갈피위치
//    let locationType: LocationType
//    /// 위치정보 입력한 날짜
//    let date: String
//    /// 책제목
//    let title: String
//    /// (책갈피위치만) 기록된 페이지
//    let readPage: Int
//}

struct Location: Identifiable, Equatable {
    
    /// 서버에서 전달받을 위치 ID값
    let id: Int
    /// 위도, 경도
    let coordinates: CLLocationCoordinate2D
    /// 대표위치/책갈피위치
    let locationType: LocationType
    
    /// id값을 0부터 1, 2, 3 부여하기 위한 변수
    private static var nextID = 0
    
    init(_ location: CLLocationCoordinate2D, _ locationType: LocationType) {
        self.id = Location.nextID
        self.coordinates = location
        self.locationType = locationType
        // 객체가 만들어질 때마다 다음에 부여할 ID 늘려주기
        Location.nextID += 1
    }
    
    static func == (lhs: Location, rhs: Location) -> Bool {
        lhs.id == rhs.id
    }
    
}

enum LocationType {
    /// 대표위치
    case main
    /// 책갈피위치
    case bookmark
}
