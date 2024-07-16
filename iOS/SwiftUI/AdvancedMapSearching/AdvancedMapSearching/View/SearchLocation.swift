//
//  SearchView.swift
//  AdvancedMapSearching
//
//  Created by 석민솔 on 6/30/24.
//

import SwiftUI
import MapKit

struct SearchLocation: View {
    @StateObject var locationManager: LocationManager = .init()
    /// SearchLocation(현재 화면) 모달 취소 버튼 누르면 없어지도록 하기 위한 변수
    @Binding var showingSearchLocation: Bool
    /// 위치 선택 모달 띄우기 위한 변수
    @State private var showingMapViewSelection = false
    var body: some View {
        VStack {
            // 위치 검색 박스
            locationSearchBox
                .padding(.bottom, 10)
            
            List {
                // MARK: 현재 위치
                currentLocationRowButton
                
                // MARK: 위치검색결과 리스트
                if let places = locationManager.fetchedPlaces, !places.isEmpty {
                    Section("지도 위치") {
                        ForEach(places, id: \.self) { place in
                            Button {
                                // Setting Map Region
                                if let coordinate = place.location?.coordinate {
                                    locationManager.pickedLocation = .init(latitude: coordinate.latitude, longitude: coordinate.longitude)
                                    locationManager.mapView.region = .init(center: coordinate, latitudinalMeters: 1000, longitudinalMeters: 1000)
                                    locationManager.addPin(at: coordinate)
                                    locationManager.pickedPlaceMark = place
//                                    locationManager.updatePlacemark(location: .init(latitude: coordinate.latitude, longitude: coordinate.longitude))
                                }
                                
                                
                                // Navigating to MapView
                                showingMapViewSelection = true
                                
                            } label: {
                                VStack(alignment: .leading, spacing: 6.0) {
                                    // 장소 이름
                                    Text(place.name ?? "")
                                        .font(.headline)
                                        .foregroundStyle(Color.black)
                                    // 주소
                                    // (임시) 함수로도 사용해보려고 했으나..뷰라서 아직 좋은 방법을 못찾음
                                    Text([place.country, place.administrativeArea, place.locality, place.thoroughfare, place.subThoroughfare].compactMap { $0 }.joined(separator: " "))
                                        .font(.caption)
                                        .foregroundStyle(Color.gray)
                                }
                            }
                        }
                    }
                }
                // MARK: 최근 검색 위치 리스트
                else if var recentLocations = RecentLocationData.locations, !recentLocations.isEmpty {
                    Section("최근 위치") {
                        ForEach(recentLocations) { place in
                            Button {
                                // Setting Map Region
                                let coordinate = place.coordinate
                                locationManager.pickedLocation = .init(latitude: coordinate.latitude, longitude: coordinate.longitude)
                                locationManager.mapView.region = .init(center: coordinate, latitudinalMeters: 1000, longitudinalMeters: 1000)
                                locationManager.addPin(at: coordinate)
                                locationManager.updatePlacemark(location: .init(latitude: coordinate.latitude, longitude: coordinate.longitude))
                                
                                
                                // Navigating to MapView
                                showingMapViewSelection = true
                                
                            } label: {
                                VStack(alignment: .leading, spacing: 6.0) {
                                    // 장소 이름
                                    Text(place.placeName)
                                        .font(.headline)
                                        .foregroundStyle(Color.black)
                                    // 주소
                                    Text(place.address)
                                        .font(.caption)
                                        .foregroundStyle(Color.gray)
                                }
                            }
//                            .swipeActions(edge: .trailing) {
//                                Button {
//                                    print("delete")
//                                    // TODO: 리스트에서 이미지 모양으로 밀어서 없애기
//                                    if let index = RecentLocationData.locations?.firstIndex(where: { $0.id == place.id }) {
//                                        print("index: \(index)")
//                                        withAnimation {
//                                            recentLocations.remove(at: index)
//                                            RecentLocationData.locations?.remove(at: index)
//                                        }
//                                    }
//                                } label: {
//                                    Image(systemName: "trash")
//                                }
//                                .tint(.red)
//                            }
                        }
                        .onDelete { IndexSet in
                            print("onDelete")
                            recentLocations.remove(atOffsets: IndexSet)
                            RecentLocationData.locations?.remove(atOffsets: IndexSet)
                        }
                    }
                }
            }
            .listStyle(.plain)
            .padding(.leading, -10) // 리스트가 지나치게 왼쪽 여백이 많아서
            .padding(.trailing, -15) // delete 할 때 오른쪽이 붕떠서..^^
        }
        .padding()
        .frame(maxHeight: .infinity, alignment: .top)
        .navigationBarItems(trailing: Button("취소") {
            showingSearchLocation = false
        })
        .navigationBarTitle(Text("위치 검색"), displayMode: .inline)
        // MapViewSelection sheet로 보여주기
        .sheet(isPresented: $showingMapViewSelection) {
            MapViewSelection(showingSearchLocation: $showingSearchLocation, showingMapViewSelection: $showingMapViewSelection)
                .environmentObject(locationManager)
                .toolbarRole(.editor)
        }
    }
}

#Preview {
    SearchLocation(showingSearchLocation: .constant(true))
}

extension SearchLocation {
    private var locationSearchBox: some View {
        HStack(spacing: 10) {
            Image(systemName: "magnifyingglass")
                .foregroundStyle(Color.gray)
            
            TextField("위치", text: $locationManager.searchText)
        }
        .padding(.vertical, 12)
        .padding(.horizontal)
        .background(
            RoundedRectangle(cornerRadius: 10, style: .continuous)
                .foregroundStyle(Color(red: 0.96, green: 0.96, blue: 0.96))
        )
    }
    
    private var currentLocationRowButton: some View {
        Button {
            // MARK: Setting Map Region
            if let coordinate = locationManager.userLocation?.coordinate {
                locationManager.mapView.region = .init(center: coordinate, latitudinalMeters: 1000, longitudinalMeters: 1000)
                locationManager.addPin(at: coordinate)
                locationManager.updatePlacemark(location: .init(latitude: coordinate.latitude, longitude: coordinate.longitude))
                
                // MARK: Navigating to MapView
                showingMapViewSelection = true
            }
            
        } label: {
            Label {
                Text("현재 위치")
//                            .font(.callout)
                    .foregroundStyle(.black/*TODO: 나중에 black0으로 바꾸기*/)
            } icon: {
                Image(systemName: "location.circle.fill")
                    .symbolRenderingMode(.palette)
                    .foregroundStyle(.blue, Color(red: 209/255, green: 209/255, blue: 214/255))
                    .font(.title2)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}



//func getAddress(place: CLPlacemark) -> String {
//    return [place.country, place.administrativeArea, place.locality, place.thoroughfare, place.subThoroughfare].compactMap { $0 }.joined(separator: " ")
//}
