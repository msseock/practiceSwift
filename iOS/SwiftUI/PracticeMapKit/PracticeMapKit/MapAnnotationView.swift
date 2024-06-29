//
//  MapAnnotation.swift
//  PracticeMapKit
//
//  Created by 석민솔 on 5/14/24.
//

import SwiftUI
import MapKit

struct MapAnnotationView: View {

    
    // 마커 표시할 CLLocationCoordinate2D 객체
    let mark1 = CLLocationCoordinate2D(latitude: 37.628000, longitude: 127.090230)
    
    
    let mark2 = CLLocationCoordinate2D(latitude: 37.637752, longitude: 127.078139)

    let mark3 = CLLocationCoordinate2D(latitude: 37.624777, longitude: 127.084938)
    
    
    @State var camera: MapCameraPosition = .automatic
    
    var body: some View {
        Map(/*position: $camera*/) {
            Annotation("", coordinate: mark1) {
                Image(systemName: "book.circle.fill")
                    .resizable()
                    .frame(width: 30, height: 30)
                    .foregroundStyle(.yellow)
                    .background(.white)
                    .clipShape(Circle())
                    .shadow(color: .black.opacity(0.3), radius: 1, x: 0, y: 1)
                    .onTapGesture {
                        print("I'm selected!")
                    }
            }
                
            Annotation("", coordinate: mark2) {
                Image(systemName: "bookmark.circle.fill")
                    .resizable()
                    .frame(width: 30, height: 30)
                    .foregroundStyle(.green)
                    .background(.white)
                    .clipShape(Circle())
                    .shadow(color: .black.opacity(0.3), radius: 1, x: 0, y: 1)
                    .onTapGesture {
                        print("I'm selected!")
                    }
            }
            
            Annotation("", coordinate: mark3) {
                Image(systemName: "bookmark.circle.fill")
                    .resizable()
                    .frame(width: 30, height: 30)
                    .foregroundStyle(.green)
                    .background(.white)
                    .clipShape(Circle())
                    .shadow(color: .black.opacity(0.3), radius: 1, x: 0, y: 1)
                    .onTapGesture {
                        print("I'm selected!")
                    }
            }
        }
        .safeAreaInset(edge: .bottom) {
            HStack {
                Button("Come Here!") {
                    withAnimation(.bouncy) {
                        camera = .region(MKCoordinateRegion(center: mark1, latitudinalMeters: 500, longitudinalMeters: 500))
                    }
                }
            }
            .frame(maxWidth: .infinity)
            .padding()
            .background(.white)
        }
    }
}

#Preview {
    MapAnnotationView()
}
