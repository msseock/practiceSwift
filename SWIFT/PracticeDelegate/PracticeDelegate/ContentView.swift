//
//  ContentView.swift
//  PracticeDelegate
//
//  Created by 석민솔 on 7/11/25.
//

import SwiftUI

struct ContentView: View {
    let assistant = AssistantManager()
    let manager = Manager()
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
            Button("touch") {
                manager.delegate = assistant
                manager.assignOrientationTask()
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
