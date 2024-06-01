//
//  ContentView.swift
//  PracticeSTT
//
//  Created by 석민솔 on 6/1/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = SpeechViewModel()

    var body: some View {
        VStack(spacing: 30) {
            Text(viewModel.recognizedText)
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(10)
//                .padding()

            Button(action: {
                viewModel.startRecording()
            }) {
                Text(viewModel.isRecording ? "Stop Recording" : "Start Recording")
                    .foregroundColor(.white)
                    .padding()
                    .background(viewModel.isRecording ? Color.red : Color.blue)
                    .cornerRadius(10)
            }
            
            Button {
                if !viewModel.isRecording {
                    withAnimation {
                        viewModel.recognizedText = "Press the button and start speaking"
                    }
                }
            } label: {
                Text("Reset")
            }

        }
        .padding()
    }
}

#Preview {
    ContentView()
}
