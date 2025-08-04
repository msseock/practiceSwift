//
//  ContentView.swift
//  PracticeARHeight
//
//  Created by 석민솔 on 7/1/25.
//

import SwiftUI

// 메인 컨텐츠 뷰
struct ContentView: View {
    @StateObject private var tiltCollector: TiltDataCollector
    @StateObject private var tiltManager: TiltManager
    @StateObject private var heightManager = HeightManager(idealHeight: 1.1)
    
    init(tiltCollector: TiltDataCollector = TiltDataCollector()) {
        self._tiltCollector = StateObject(wrappedValue: tiltCollector)
        self._tiltManager = StateObject(wrappedValue: TiltManager(properTilt: Tilt(degreeX: 0, degreeZ: -0.5), dataCollector: tiltCollector))
    }

    var body: some View {
        ZStack {
            // AR 카메라 뷰
            HeightMeasurementARView(
                measuredHeight: $heightManager.measuredHeight,
                isGroundFound: $heightManager.isGroundFound
            )
                .edgesIgnoringSafeArea(.all)

            VStack(alignment: .center) {
                Spacer()
                
                // 원점이 설정된 후에만 높이를 표시
                if heightManager.isGroundFound {
                    Text(String(format: "%.0f cm", heightManager.offsetY))
                    HeightFeedbackView(offsetY: CGFloat(heightManager.offsetY))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading, 20)
                }
                
                Spacer()
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.leading, 20)
            
            TiltFeedbackView(
                offsetX: tiltManager.offsetX,
                offsetY: tiltManager.offsetZ
            )
            
            // AR 원점이 설정되기 전까지 안내 문구 표시
            if !heightManager.isGroundFound {
                VStack {
                    Text("바닥을 인식 중입니다...\n아이폰을 바닥을 향해 천천히 움직여주세요.")
                        .font(.headline)
                        .multilineTextAlignment(.center)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.black.opacity(0.6))
                        .cornerRadius(10)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
        }
        .onAppear {
            // 뷰가 나타날 때 - 화면 자동 꺼짐 비활성화
            UIApplication.shared.isIdleTimerDisabled = true
        }
        .onDisappear {
            // 뷰가 사라질 때 - 화면 자동 꺼짐 다시 활성화 (배터리 절약)
            UIApplication.shared.isIdleTimerDisabled = false
        }
    }
}

