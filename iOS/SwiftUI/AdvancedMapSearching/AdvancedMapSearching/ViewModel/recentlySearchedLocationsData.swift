//
//  recentlySearchedLocationsData.swift
//  AdvancedMapSearching
//
//  Created by 석민솔 on 7/1/24.
//

import MapKit

class RecentLocationData {
    static var locations: [recentlySearchedLocation]? = [
        recentlySearchedLocation(placeName: "서울여자대학교 근처 어딘가1", address: "대한민국 서울특별시 공릉동 123", coordinate: CLLocationCoordinate2D(latitude: 37.628000, longitude: 127.090230)),
        recentlySearchedLocation(placeName: "서울여자대학교 근처 어딘가2", address: "대한민국 서울특별시 공릉동 123", coordinate: CLLocationCoordinate2D(latitude: 37.624777, longitude: 127.084938)),
        recentlySearchedLocation(placeName: "서울여자대학교 근처 어딘가2.1", address: "대한민국 서울특별시 공릉동 123", coordinate: CLLocationCoordinate2D(latitude: 37.624777, longitude: 127.084938)),
        recentlySearchedLocation(placeName: "서울여자대학교 근처 어딘가2.2", address: "대한민국 서울특별시 공릉동 123", coordinate: CLLocationCoordinate2D(latitude: 37.624777, longitude: 127.084938)),
        recentlySearchedLocation(placeName: "서울여자대학교 근처 어딘가3", address: "대한민국 서울특별시 공릉동 123", coordinate: CLLocationCoordinate2D(latitude: 37.637752, longitude: 127.078139))
    ]
    
//    init() {
//        RecentLocationData.locations = [
//            recentlySearchedLocation(placeName: "서울여자대학교 근처 어딘가1", address: "대한민국 서울특별시 공릉동 123", coordinate: CLLocationCoordinate2D(latitude: 37.628000, longitude: 127.090230)),
//            recentlySearchedLocation(placeName: "서울여자대학교 근처 어딘가2", address: "대한민국 서울특별시 공릉동 123", coordinate: CLLocationCoordinate2D(latitude: 37.624777, longitude: 127.084938)),
//            recentlySearchedLocation(placeName: "서울여자대학교 근처 어딘가2.1", address: "대한민국 서울특별시 공릉동 123", coordinate: CLLocationCoordinate2D(latitude: 37.624777, longitude: 127.084938)),
//            recentlySearchedLocation(placeName: "서울여자대학교 근처 어딘가2.2", address: "대한민국 서울특별시 공릉동 123", coordinate: CLLocationCoordinate2D(latitude: 37.624777, longitude: 127.084938)),
//            recentlySearchedLocation(placeName: "서울여자대학교 근처 어딘가3", address: "대한민국 서울특별시 공릉동 123", coordinate: CLLocationCoordinate2D(latitude: 37.637752, longitude: 127.078139))
//        ]
//    }
}
