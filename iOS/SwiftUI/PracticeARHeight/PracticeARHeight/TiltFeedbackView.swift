//
//  TiltFeedbackView.swift
//  PracticeARHeight
//
//  Created by 석민솔 on 7/13/25.
//

import SwiftUI

/// 기울기 피드백을 원형 가이드에 맞춰서 보여주는 뷰
struct TiltFeedbackView: View {
    var offsetX: CGFloat
    var offsetY: CGFloat
    
    var isProperPosition: Bool {
        if abs(offsetX) < 3 && abs(offsetY) < 3 {
            return true
        } else {
            return false
        }
    }
    
    var body: some View {
        // 가이드 동그라미
        Circle()
            .stroke(lineWidth: 1)
            .frame(width: 10, height: 10)
            .foregroundStyle(isProperPosition ? Color.blue : Color.white)
            .overlay(
                // 피드백 동그라미
                Circle()
                    .frame(width: 6, height: 6)
                    .offset(x: offsetX, y: offsetY)
                    .foregroundStyle(isProperPosition ? Color.blue : Color.white)
            )
    }
}

#Preview {
    TiltFeedbackView(offsetX: 0, offsetY: 0)
}
