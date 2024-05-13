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
            
            VStack {
                Spacer()
                
                VStack {
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
    }
}

#Preview {
    Home()
}
