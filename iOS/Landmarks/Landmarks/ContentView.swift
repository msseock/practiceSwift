//
//  ContentView.swift
//  Landmarks
//
//  Created by 석민솔 on 11/22/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        // Embed the VStack that holds the three text views in another VStack.
        VStack {
            // Add your custom MapView to the top of the stack.
            MapView()
                .frame(height: 300)
                // When you specify only the height parameter, the view automatically sizes to the width of its content.
            
            // Add the CircleImage view to the stack.
            CircleImage()
                // To layer the image view on top of the map view, give the image an offset of -130 points vertically, and padding of -130 points from the bottom of the view.
                .offset(y: -130)
                .padding(.bottom, -130)
                // These adjustments make room for the text by moving the image upwards.
            

            
            VStack {
                VStack(alignment: .leading) {
                    Text("Turtle Rock")
                        .font(.title)
                    HStack {
                        Text("Joshua Tree National Park")
                        Spacer()
                        Text("California")
                    }
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                    
                    Divider()
                    
                    Text("About Turtle Rock")
                        .font(.title2)
                    Text("Descriptive Text goes here")
                }
                .padding()
                
                // Add a spacer at the bottom of the outer VStack to push the content to the top of the screen.
                Spacer()
            }
        }
    }
}

#Preview {
    ContentView()
}
