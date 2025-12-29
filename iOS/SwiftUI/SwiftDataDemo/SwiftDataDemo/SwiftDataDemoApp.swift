//
//  SwiftDataDemoApp.swift
//  SwiftDataDemo
//
//  Created by 석민솔 on 4/15/25.
//

import SwiftUI
import SwiftData

@main
struct SwiftDataDemoApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: DataItem.self)
    }
}
