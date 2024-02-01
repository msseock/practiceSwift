//
//  MemeCreatorApp.swift
//  MemeCreator
//
//  Created by 석민솔 on 2/1/24.
//

import SwiftUI

@main
struct MemeCreatorApp: App {
    @StateObject private var fetcher = PandaCollectionFetcher()
    
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                MemeCreator()
                    .environmentObject(fetcher)
            }
        }
    }
}
