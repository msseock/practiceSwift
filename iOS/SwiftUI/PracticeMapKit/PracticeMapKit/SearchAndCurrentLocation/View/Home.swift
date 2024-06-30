//
//  Home.swift
//  PracticeMapKit
//
//  Created by 석민솔 on 5/13/24.
//

import SwiftUI
import CoreLocation

struct Home: View {
    @StateObject var mapData = MapViewModel()
    // Location Manager..
    @State var locationManager = CLLocationManager()
    
    var body: some View {
        ZStack {
            
            // MapView..
            MapView()
            // using it as environment object so that it can be used ints subViews...
                .environmentObject(mapData)
                .ignoresSafeArea(.all, edges: .all)
                .onTapGesture {
                    withAnimation {
                        UIApplication.shared.hideKeyboard()
                        mapData.searchTxt = ""
                    }
                }
            
            VStack {
                // MARK: 검색창
                VStack {
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundStyle(Color.gray)
                        
                        TextField("Search", text: $mapData.searchTxt)
                            .colorScheme(.light)
                    }
                    .padding(.vertical, 10)
                    .padding(.horizontal)
                    .background(Color.white)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    
                    // MARK: 검색결과
                    if !mapData.places.isEmpty && mapData.searchTxt != "" {
                        ScrollView {
                            
                            VStack(spacing: 15) {
                                
                                ForEach(mapData.places) { place in
                                    Text(place.place.name ?? "")
                                        .foregroundStyle(.black)
                                            .frame(maxWidth: .infinity, alignment: .leading)
                                            .padding(.leading)
                                            .onTapGesture {
                                                mapData.selectPlace(place: place)
                                                UIApplication.shared.hideKeyboard()
                                            }
                                    
                                    Text(place.address)
                                        .font(.caption)
                                            .frame(maxWidth: .infinity, alignment: .leading)
                                            .padding(.leading)
                                    
                                    Divider()
                                }
                            }
                            .padding(.top)
                        }
                        .background(Color.white)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                    }
                }
                .padding()
                
                Spacer()
                
                VStack {
                    // MARK: 현재 위치로 이동 버튼
                    Button(action: mapData.focusLocation, label: {
                        Image(systemName: "location.fill")
                            .font(.title2)
                            .padding(10)
                            .background(Color.primary)
                            .clipShape(Circle())
                    })
                }
                .frame(maxWidth: .infinity, alignment: .trailing)
                .padding()
            }
        }
        .onAppear(perform: {
            // Setting Delegate
            locationManager.delegate = mapData
            locationManager.requestWhenInUseAuthorization()
        })
        
        // Permission Denied Alert...
        .alert(isPresented: $mapData.permissionDenied) {
            Alert(title: Text("Permission Denied"), message: Text("Please Enable Permission In App Settings"), dismissButton: .default(Text("Goto Settings"), action: {
                
                // Redirecting User To Settings...
                if let appSetting = URL(string: UIApplication.openSettingsURLString) {
                    UIApplication.shared.open(appSetting)
                }
            }))
        }
        .onChange(of: mapData.searchTxt) {
            // Searching Places...
            
            // You can use your own delay time to avoid Continous Search Request...
            let delay = 0.3
            
            DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
                // Search...
                self.mapData.searchQuery()
            }
        }
    }
}

#Preview {
    Home()
}

extension UIApplication {
    func hideKeyboard() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
