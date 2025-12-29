//
//  SingleHapticTestView.swift
//  HapticPlayer
//
//  Created by 석민솔 on 11/11/25.
//

import SwiftUI

struct SingleHapticTestView: View {
    @State private var intensity: Float = 0.5
    @State private var sharpness: Float = 0.5
    @State private var duration: Double = 1.0
    
    var body: some View {
        VStack(spacing: 20) {
            Text("단일 햅틱 테스트")
                .font(.title)
                .fontWeight(.bold)

            HapticVariablesSliders(intensity: $intensity, sharpness: $sharpness, duration: $duration)
            
            // 재생 버튼
            Button {
                HapticManager.shared.playHaptic(
                    intensity: intensity,
                    sharpness: sharpness,
                    duration: duration
                )
            } label: {
                Text("재생")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(10)
            }
            .padding(.horizontal)
        }
        .padding()
    }
}
#Preview {
    SingleHapticTestView()
}
