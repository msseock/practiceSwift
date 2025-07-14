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
    @StateObject private var heightManager = HeightManager()
    
    init(tiltCollector: TiltDataCollector = TiltDataCollector()) {
        self._tiltCollector = StateObject(wrappedValue: tiltCollector)
        self._tiltManager = StateObject(wrappedValue: TiltManager(dataCollector: tiltCollector))
    }

    var body: some View {
        ZStack {
            // AR 카메라 뷰
            ARViewContainer(measuredHeight: $heightManager.measuredHeight, isGroundFound: $heightManager.isGroundFound)
                .edgesIgnoringSafeArea(.all)

            VStack(alignment: .center) {
                Spacer()
                
                // 원점이 설정된 후에만 높이를 표시
                if heightManager.isGroundFound {
                    Text(String(format: "%.0f cm", heightManager.offsetY))
                    HeightFeedbackView(offsetY: CGFloat(heightManager.offsetY))
                }
                
                Spacer()
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.leading, 20)
            
            TiltFeedbackView(offsetX: CGFloat(tiltManager.offsetX), offsetY: CGFloat(tiltManager.offsetZ))
            
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
            UIApplication.shared.isIdleTimerDisabled = true
        }
        .onDisappear {
            UIApplication.shared.isIdleTimerDisabled = false
        }
    }
}

