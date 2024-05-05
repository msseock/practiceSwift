//
//  ContentView.swift
//  PracticeChat
//
//  Created by 석민솔 on 5/5/24.
//

import SwiftUI

struct ContentView: View {
    @State private var message: String = ""
    @State private var messages = ["Welcome to GeminiChat!"]
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
