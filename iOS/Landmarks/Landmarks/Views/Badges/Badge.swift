//
//  Badge.swift
//  Landmarks
//
//  Created by 석민솔 on 1/16/24.
//

import SwiftUI

struct Badge: View {
    var badgeSymbols: some View {
        // Add a ForEach view to rotate and display copies of the badge symbol.
        ForEach(0..<8) { index in
            RotatedBadgeSymbol(
                angle: .degrees(Double(index) / Double(8)) * 360.0
            )
        }
        .opacity(0.5)
    }
    
    var body: some View {
        VStack {
            ZStack {
                BadgeBackground()
                
                GeometryReader { geometry in
                    badgeSymbols
                        .scaleEffect(1.0 / 4.0, anchor: .top)
                        .position(x: geometry.size.width / 2.0, y: (3.0 / 4.0) * geometry.size.height)
                }
            }
            .scaledToFit()
            
//            // 책장 연습용
//            HStack(alignment: .bottom, spacing: 3) {
//                ForEach(0..<10) { index in
//                    RoundedRectangle(cornerRadius: 3)
//                        .frame(
//                            width: CGFloat(Int.random(in: 15...40)),
//                            height: CGFloat(Int.random(in: 100...130))
//                        )
//                        .foregroundColor(
//                            Color(red: 33 / 255,
//                                  green: 60 / 255,
//                                  blue: 118 / 225)
//                        )
//                        .opacity(Double.random(in: 0.4...1))
//                }
//                Spacer()
//            }
//            .padding(10)
        }
    }
}

#Preview {
    Badge()
}
