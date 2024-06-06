//
//  BookMapView.swift
//  PracticeMapKit
//
//  Created by 석민솔 on 6/6/24.
//

import SwiftUI
import MapKit

struct BookMapView: View {
    @ObservedObject private var annotations = AnnotationsStore()
    
    // MARK: - 마커 이미지 변수들
    let mainLocationImage_inactive: some View = Image(systemName: "book.circle.fill")
                                        .resizable()
                                        .frame(width: 30, height: 30)
                                        .foregroundStyle(.yellow)
                                        .background(.white)
                                        .clipShape(Circle())
                                        .shadow(color: .black.opacity(0.3), radius: 1, x: 0, y: 1)

    let mainLocationImage_active: some View = Image(systemName: "book.circle.fill")
                                        .resizable()
                                        .frame(width: 50, height: 50)
                                        .foregroundStyle(.yellow)
                                        .background(.white)
                                        .clipShape(Circle())
                                        .shadow(color: .black.opacity(0.3), radius: 1, x: 0, y: 1)

    let bookmarkLocationImage_inactive: some View = Image(systemName: "bookmark.circle.fill")
                                            .resizable()
                                            .frame(width: 30, height: 30)
                                            .foregroundStyle(.green)
                                            .background(.white)
                                            .clipShape(Circle())
                                            .shadow(color: .black.opacity(0.3), radius: 1, x: 0, y: 1)

    let bookmarkLocationImage_active: some View = Image(systemName: "bookmark.circle.fill")
                                            .resizable()
                                            .frame(width: 50, height: 50)
                                            .foregroundStyle(.green)
                                            .background(.white)
                                            .clipShape(Circle())
                                            .shadow(color: .black.opacity(0.3), radius: 1, x: 0, y: 1)

    // MARK: - 뷰
    var body: some View {
        Map() {
            // 마커 표시
            ForEach(annotations.items) { annotation in
                Annotation("", coordinate: annotation.locationInfo.location) {
                    switch annotation.locationInfo.locationType {
                    // 책갈피 마커
                    case .bookmark:
                        if annotation.isActive {
                            // 책갈피 마커 활성화 상태
                            bookmarkLocationImage_active
                        } else {
                            // 책갈피 마커 기본 비활성화 상태(동그라미)
                            bookmarkLocationImage_inactive
                                .onTapGesture {
                                    withAnimation(.bouncy) {
                                        // 선택한 annotation만 활성화되도록
                                        annotations.deactivateAllExcept(annotation)
                                        annotation.isActive.toggle()
                                        // TODO: 지도 여기로 focus
                                        // TODO: bottom sheet 위로 올려서 정보 보여주기
                                    }
                                    print("Tapped! id: \(annotation.id), active: \(annotation.isActive)")
                                    for annotation in annotations.items {
                                        print(annotation.id, annotation.isActive)
                                    }
                                    print("\n")
                                }
                        }
                        
                    // 대표위치 마커
                    case .main:
                        if annotation.isActive {
                            // 대표위치 마커 활성화 상태
                            mainLocationImage_active
                        } else {
                            // 대표위치 마커 기본 비활성화 상태(동그라미)
                            mainLocationImage_inactive
                                .onTapGesture {
                                    withAnimation(.bouncy) {
                                        // 선택한 annotation만 활성화되도록
                                        annotations.deactivateAllExcept(annotation)
                                        annotation.isActive.toggle()
                                        // TODO: 지도 여기로 focus
                                        // TODO: bottom sheet 위로 올려서 정보 보여주기
                                    }
                                    print("Tapped! id: \(annotation.id), active: \(annotation.isActive)")
                                }
                        }
                    }
                }
            }
        }
    }
}

class AnnotationsStore: ObservableObject {
    @Published var items: [SingleAnnotation] = []
    
    init() {
        items = [
            SingleAnnotation(
                LocationInfo(location: CLLocationCoordinate2D(latitude: 37.628000, longitude: 127.090230),
                            locationType: .bookmark,
                            date: "2024.06.06",
                            title: "천 개의 파랑",
                            readPage: 100)),
            SingleAnnotation(
                LocationInfo(location: CLLocationCoordinate2D(latitude: 37.637752, longitude: 127.078139),
                             locationType: .bookmark,
                             date: "2024.06.06",
                             title: "천 개의 파랑",
                             readPage: 100)),
            SingleAnnotation(
                LocationInfo(location: CLLocationCoordinate2D(latitude: 37.624777, longitude: 127.084938),
                             locationType: .main,
                             date: "2024.06.06",
                             title: "천 개의 파랑",
                             readPage: 100))
        ]
    }
    
    // 선택한 것 제외한 annotation 모두 비활성화시키기
    func deactivateAllExcept(_ activeAnnotation: SingleAnnotation) {
        for annotation in items {
            if annotation.id != activeAnnotation.id {
                annotation.isActive = false
            }
        }
    }
}
