//
//  MapViewSelection.swift
//  AdvancedMapSearching
//
//  Created by 석민솔 on 7/1/24.
//

import SwiftUI

// MARK: MapView Live Selection
struct MapViewSelection: View {
    @EnvironmentObject var locationManager: LocationManager
    
    /// SearchLocation(부모 화면) 모달 취소 버튼 누르면 없어지도록 하기 위한 변수
    @Binding var showingSearchLocation: Bool
    
    /// MapViewSelection(현재 화면) 모달 취소 버튼 누르면 없어지도록 하기 위한 변수
    @Binding var showingMapViewSelection: Bool
    
    var body: some View {
        ZStack {
            MapViewHelper()
                .environmentObject(locationManager)
                .ignoresSafeArea()
                        
            // MARK: Displaying Data
            if let place = locationManager.pickedPlaceMark {
                VStack(spacing: 15) {
                    Text("위치 선택")
                        .font(.title2.bold())
                    
                    HStack(spacing: 15) {
                        Image(systemName: "mappin.circle.fill")
                            .font(.title2)
                            .foregroundStyle(Color.gray)
                        
                        VStack(alignment: .leading, spacing: 6.0) {
                            // 장소 이름
                            Text(place.name ?? "")
                                .font(.title3.bold())
                            // 주소
                            Text([place.country, place.administrativeArea, place.locality, place.thoroughfare, place.subThoroughfare].compactMap { $0 }.joined(separator: " "))
                                .font(.caption)
                                .foregroundStyle(Color.gray)
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.vertical, 10)
                    
                    Button {
                        // TODO: 최종선택위치 결정하기
                        
                        // SearchLocation, 현재화면 닫기
                        showingMapViewSelection = false
                        showingSearchLocation = false
                    } label: {
                        Text("여기로 정하기")
                            .fontWeight(.semibold)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 12)
                            .background {
                                RoundedRectangle(cornerRadius: 10, style: .continuous)
                                    .fill(.accent)
                            }
                            .overlay(alignment: .trailing) {
                                Image(systemName: "arrow.right")
                                    .font(.title3.bold())
                                    .padding(.trailing)
                            }
                            .foregroundStyle(Color.white)
                    }
                }
                .padding()
                .background {
                    RoundedRectangle(cornerRadius: 10, style: .continuous)
                        .fill(.white)
                        .ignoresSafeArea()
                }
                .frame(maxHeight: .infinity, alignment: .bottom)
            }
        }
        .onDisappear {
            locationManager.pickedLocation = nil
            locationManager.pickedPlaceMark = nil
            
            locationManager.mapView.removeAnnotations(locationManager.mapView.annotations)
        }
    }
}


//#Preview {
//    MapViewSelection()
//}
