//
//  Place.swift
//  PracticeMapKit
//
//  Created by 석민솔 on 5/22/24.
//

import SwiftUI
import MapKit
import Observation

struct Place: Identifiable {
    
    var id = UUID().uuidString
    
    var place: CLPlacemark
    
    /// 자세한 주소
    var address: String {
        /// 위치정보 연결해서 주소 형태로 만들기
        var address = [self.place.country, self.place.administrativeArea, self.place.locality, self.place.thoroughfare, self.place.subThoroughfare].compactMap { $0 }.joined(separator: " ")
        
        return address
    }
}


// MARK: 여기부턴 문법검사 참고용


//struct LocationInfo {
//    /// 위경도 정보
//    let location: CLLocationCoordinate2D
//    /// 대표위치/책갈피위치
//    let locationType: LocationType
//    /// 위치정보 입력한 날짜
//    let date: String
//    /// 책제목
//    let title: String
//    /// (책갈피위치만) 기록된 페이지
//    let readPage: Int
//}
//
//@Observable
//class SingleAnnotation {
//    let locationInfo: LocationInfo
//    var isActive: Bool {
//        didSet {
//            if isActive {
//                // 다른 모든 객체들의 isActive를 false로 설정
//                deactivateOthers(except: self)
//            }
//        }
//    }
//    
//    init(locationInfo: LocationInfo, isActive: Bool) {
//        self.locationInfo = locationInfo
//        self.isActive = isActive
//    }
//    
//    // 다른 모든 객체들의 isActive를 false로 설정하는 메서드
//    func deactivateOthers(except activeObject: SingleAnnotation) {
//        for object in SingleAnnotation.allAnnotaions {
//            if object !== activeObject {
//                object.isActive = false
//            }
//        }
//    }
//    
//    // 모든 객체를 저장하는 배열 (static)
//    static var allAnnotaions: [SingleAnnotation] = []
//}
//
//enum LocationType {
//    case main
//    case bookmark
//}


//// BookMap에서 뒤쪽에 annotation 표시하는 뷰...
//struct MapAnnotation: View {
//    @State private var Annotations = [LocationInfo]
//
//    var body: some View {
//        Map() {
//            // 마커 표시
//            ForEach(Annotations) { annotation in
//                Annotation("", coordinate: annotation.locationInfo.location) {
//                    switch locationInfo.locationType {
//                    // 책갈피 마커
//                    case .bookmark:
//                        bookmarkLocationImage_inactive
//                            .onTapGesture {
//                                // TODO: 마커 모양 바꾸기
//                                // TODO: 지도 여기로 focus
//                                // TODO: bottom sheet 위로 올려서 정보 보여주기
//                            }
//                    // 대표위치 마커
//                    case .main:
//                        
//                    }
//                    // 책갈피 - 비활성
//                    // 책갈피 - 활성
//                    // 대표위치 - 비활성
//                    // 대표위치 - 활성
//                    Image(systemName: "book.circle.fill")
//                        .resizable()
//                        .frame(width: 30, height: 30)
//                        .foregroundStyle(.yellow)
//                        .background(.white)
//                        .clipShape(Circle())
//                        .shadow(color: .black.opacity(0.3), radius: 1, x: 0, y: 1)
//                        .onTapGesture {
//                            print("I'm selected!")
//                        }
//                }
//            }
//        }
//    }
//}
//
//extension MapAnnotation {
//    /// 대표위치 - 비활성상태일 때 보여주는 노란 동그라미 이미지
//    let mainLocationImage_inactive = Image(systemName: "book.circle.fill")
//                                        .resizable()
//                                        .frame(width: 30, height: 30)
//                                        .foregroundStyle(.yellow)
//                                        .background(.white)
//                                        .clipShape(Circle())
//                                        .shadow(color: .black.opacity(0.3), radius: 1, x: 0, y: 1)
//
//    let mainLocationImage_active
//
//    let bookmarkLocationImage_inactive = Image(systemName: "bookmark.circle.fill")
//                                            .resizable()
//                                            .frame(width: 30, height: 30)
//                                            .foregroundStyle(.green)
//                                            .background(.white)
//                                            .clipShape(Circle())
//                                            .shadow(color: .black.opacity(0.3), radius: 1, x: 0, y: 1)
//
//    let bookmarkLocationImage_active
//    
//}
