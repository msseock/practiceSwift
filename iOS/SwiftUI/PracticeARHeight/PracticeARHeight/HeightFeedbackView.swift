//
//  HeightFeedbackView.swift
//  PracticeARHeight
//
//  Created by 석민솔 on 7/13/25.
//

import SwiftUI

/// 높이가 특정 일치와 일치하는지 확인하는 뷰
struct HeightFeedbackView: View {
    var offsetY: CGFloat
    
    var body: some View {
        VStack(alignment: .center, spacing: 0) {
            Text("H")
                .fontWeight(.medium)
                .padding(.bottom, 6)
            
            RoundedRectangle(cornerRadius: 10)
                .frame(width: 14, height: 2)
            
            Rectangle()
                .strokeBorder(style: StrokeStyle(lineWidth: 1, dash: [2, 2]))
                .frame(width: 1, height: 90)
            
            Circle()
                .stroke(lineWidth: 1)
                .frame(width: 8, height: 8)
                .overlay(
                    // 피드백 동그라미
                    Circle()
                        .foregroundStyle(Color(red: 0, green: 0.57, blue: 1))
                        .frame(width:8, height: 8)
                        .offset(x: 0, y: offsetY)
                )
                .animation(.easeOut(duration: 0.1), value: offsetY)
            
            Rectangle()
                .strokeBorder(style: StrokeStyle(lineWidth: 1, dash: [2, 2]))
                .frame(width: 1, height: 90)
                .zIndex(-10) // 피드백 동그라미보다 밑으로 보내기
            
            RoundedRectangle(cornerRadius: 10)
                .frame(width: 14, height: 2)
            
        }
        .foregroundStyle(Color.white)
        .padding(.horizontal, 8)
        .padding(.top, 11)
        .padding(.bottom, 20)
        .background(
            RoundedRectangle(cornerRadius: 40)
                .frame(width: 30)
                .foregroundStyle(Color.black.opacity(0.6))
        )
    }
}

#Preview {
    HeightFeedbackView(offsetY: 0.0)
}
