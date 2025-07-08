//
//  ContentView.swift
//  PracticeARHeight
//
//  Created by 석민솔 on 7/1/25.
//

import SwiftUI

// 메인 컨텐츠 뷰
struct ContentView: View {
    // 측정된 높이를 저장하는 상태 변수
    @State private var measuredHeight: Float = 0.0
    // AR 원점이 바닥을 기준으로 설정되었는지 확인하는 변수
    @State private var isOriginSet: Bool = false
    
    @StateObject private var motionManager = MotionManager()

    var body: some View {
        ZStack {
            // AR 카메라 뷰
            ARViewContainer(measuredHeight: $measuredHeight, isOriginSet: $isOriginSet)
                .edgesIgnoringSafeArea(.all)

            VStack(alignment: .center) {
                Spacer()
                
                // 원점이 설정된 후에만 높이를 표시
                if isOriginSet {
                    Text(String(format: "%.2f m", measuredHeight))
                        .font(.system(size: 80, weight: .bold, design: .rounded))
                        .shadow(color: .black.opacity(0.5), radius: 5, x: 0, y: 5)
                }
                
                
                Text("x: \(motionManager.x, specifier: "%.2f")")
                    .foregroundStyle(motionManager.properx ? .white : .red)
                Text("y: \(motionManager.y, specifier: "%.2f")")
                Text("z: \(motionManager.z, specifier: "%.2f")")
                    .foregroundStyle(motionManager.properz ? .white : .red)
                
                Spacer()
            }
            .foregroundColor(.white)
            
            // AR 원점이 설정되기 전까지 안내 문구 표시
            if !isOriginSet {
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

