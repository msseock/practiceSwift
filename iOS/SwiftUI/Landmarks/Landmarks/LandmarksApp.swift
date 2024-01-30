//
//  LandmarksApp.swift : The App conformer acts as the entryPoint for the Landmarks app, but isn't itself a view
//  Landmarks
//
//  Created by 석민솔 on 11/22/23.
//

import SwiftUI

@main
struct LandmarksApp: App {
    @State private var modelData = ModelData()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(modelData)
        }
    }
}
