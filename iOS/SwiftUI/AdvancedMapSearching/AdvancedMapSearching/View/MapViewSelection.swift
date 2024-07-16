//
//  MapViewSelection.swift
//  AdvancedMapSearching
//
//  Created by 석민솔 on 7/1/24.
//

import SwiftUI

// MARK: MapView Live Selection
struct MapViewSelection: View {
    @EnvironmentObject var locationManager: SearchLocationManager
    
    /// SearchLocation(부모 화면) 모달 취소 버튼 누르면 없어지도록 하기 위한 변수
    @Binding var showingSearchLocation: Bool
    
    /// MapViewSelection(현재 화면) 모달 취소 버튼 누르면 없어지도록 하기 위한 변수
    @Binding var showingMapViewSelection: Bool
    
    /// 여기로 정하기 버튼 눌렸는지 확인하는 변수
    /// 선택하기 눌렸다면 -> 선택한 위치로 반영
    /// 선택하기 안눌린 채로 화면만 닫힌다면 -> 선택위치 해제
    @State var isConfirmed: Bool = false
    
    var body: some View {
        ZStack {
            MapViewHelper()
                .environmentObject(locationManager)
                .ignoresSafeArea()
            
            // 닫기 임시버튼
            Button {
                showingMapViewSelection = false
            } label: {
                HStack {
                    // TODO: 닫기버튼 디자인 회의결과 반영하기
                    Image(systemName: "xmark")
//                    Text("닫기")
                }
                .padding(15)
                .background(
                    RoundedRectangle(cornerRadius: 30)
                        .foregroundStyle(Color.white)
                )
            }
            .padding()
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
                        
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
                            // FIXME: API에서 받아온 텍스트 보여줄 수 있는 방법 찾기
                            // 장소 이름
                            Text(place.name ?? "없음")
                                .font(.title3.bold())
                            // 주소
                            Text(place.title ?? "주소 없음")
                                .font(.caption)
                                .foregroundStyle(Color.gray)
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.vertical, 10)
                    
                    Button {
                        // TODO: 최종선택위치 결정하기
                        isConfirmed = true
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
            // 선택 안하고 그냥 닫을 때는 선택된 것들 모두 해제시키기
            if isConfirmed == false {
                locationManager.pickedLocation = nil
                locationManager.pickedPlaceMark = nil
            } else {
                // 여기로 정하기 누른 경우에는 놔두기
            }
            
            // 지도 깔끔하게 annotation 지우기
            locationManager.mapView.removeAnnotations(locationManager.mapView.annotations)
        }
    }
}
