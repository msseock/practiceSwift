//
//  WaterWaveView.swift
//  PracticeURLSession
//
//  Created by 석민솔 on 8/20/25.
//

import SwiftUI

struct WaterWaveView: View {
    @State private var waveOffset1: CGFloat = 0
    @State private var waveOffset2: CGFloat = 0
    
    let waterHeight: CGFloat
    let waveHeight: CGFloat
    let waveSpeed: Double
    
    init(waterHeight: CGFloat, waveHeight: CGFloat = 20, waveSpeed: Double = 2.0) {
        self.waterHeight = waterHeight * 20
        self.waveHeight = waveHeight
        self.waveSpeed = waveSpeed
    }
    
    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 0) {
                // 공기 영역 (위쪽)
                Rectangle()
                    .fill(Color.clear)
                    .frame(height: max(0, geometry.size.height - waterHeight))
                
                // 물 영역 (아래쪽)
                ZStack {
                    // 첫 번째 파도 레이어
                    Wave(offset: waveOffset1, waveHeight: waveHeight, isTop: true)
                        .fill(
                            LinearGradient(
                                gradient: Gradient(colors: [
                                    Color.blue.opacity(0.7),
                                    Color.blue.opacity(0.5)
                                ]),
                                startPoint: .top,
                                endPoint: .bottom
                            )
                        )
                    
                    // 두 번째 파도 레이어 (위상차)
                    Wave(offset: waveOffset2, waveHeight: waveHeight * 0.7, isTop: true)
                        .fill(
                            LinearGradient(
                                gradient: Gradient(colors: [
                                    Color.cyan.opacity(0.6),
                                    Color.blue.opacity(0.4)
                                ]),
                                startPoint: .top,
                                endPoint: .bottom
                            )
                        )
                }
                .frame(height: min(waterHeight, geometry.size.height))
                .clipped()
            }
        }
        .onAppear {
            startWaveAnimation()
        }
    }
    
    private func startWaveAnimation() {
        withAnimation(
            Animation.linear(duration: waveSpeed)
                .repeatForever(autoreverses: false)
        ) {
            waveOffset1 = .pi * 2
        }
        
        withAnimation(
            Animation.linear(duration: waveSpeed * 1.3)
                .repeatForever(autoreverses: false)
        ) {
            waveOffset2 = -.pi * 2
        }
    }
}

#Preview {
    WaterWaveView(waterHeight: 30)
}
