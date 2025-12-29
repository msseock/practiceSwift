//
//  HapticVariablesSliders.swift
//  HapticPlayer
//
//  Created by 석민솔 on 11/11/25.
//

import SwiftUI

struct HapticVariablesSliders: View {
    @Binding var intensity: Float
    @Binding var sharpness: Float
    @Binding var duration: Double
    
    var body: some View {
        VStack(spacing: 20) {
            // Intensity
            VStack(alignment: .leading, spacing: 5) {
                Text("Intensity: \(String(format: "%.2f", intensity))")
                Slider(value: $intensity, in: 0...1)
            }
            
            // Sharpness
            VStack(alignment: .leading, spacing: 5) {
                Text("Sharpness: \(String(format: "%.2f", sharpness))")
                Slider(value: $sharpness, in: 0...1)
            }
            
            // Duration
            VStack(alignment: .leading, spacing: 5) {
                Text("Duration: \(String(format: "%.2f", duration))s")
                Slider(value: $duration, in: 0.1...3.0)
            }
        }
        .padding(.horizontal)
    }

}
