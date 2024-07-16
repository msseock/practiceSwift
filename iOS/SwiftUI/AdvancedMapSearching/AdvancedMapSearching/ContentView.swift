//
//  ContentView.swift
//  AdvancedMapSearching
//
//  Created by 석민솔 on 6/30/24.
//

import SwiftUI
import MapKit

import SwiftUI

struct ContentView: View {
    @State private var showingSearchLocation = false // 상태 변수 추가
    
    @State private var pickedPlace: MKPlacemark? = nil

    var body: some View {
        VStack {
            Button(action: {
                showingSearchLocation = true
            }) {
                if let location = pickedPlace {
                    Text(location.name ?? "몰라유")
                        .font(.title)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                } else {
                    Text("Search Location")
                        .font(.title)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
            }
            .sheet(isPresented: $showingSearchLocation) {
                NavigationView {
                    SearchLocation(showingSearchLocation: $showingSearchLocation, pickedPlaceMark: $pickedPlace)
                }
            }
        }
    }
}
#Preview {
    ContentView()
}
