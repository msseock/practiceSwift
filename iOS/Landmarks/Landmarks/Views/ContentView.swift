//
//  ContentView.swift
//  Landmarks
//
//  Created by 석민솔 on 11/22/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        LandmarkList()
    }
}

#Preview {
    ContentView()
        .environment(ModelData())
}
