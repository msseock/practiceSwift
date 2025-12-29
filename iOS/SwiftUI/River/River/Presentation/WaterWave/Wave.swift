//
//  Wave.swift
//  PracticeURLSession
//
//  Created by 석민솔 on 8/20/25.
//

import SwiftUI

struct Wave: Shape {
    var offset: CGFloat
    var waveHeight: CGFloat
    var isTop: Bool = false
    
    var animatableData: CGFloat {
        get { offset }
        set { offset = newValue }
    }
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        let width = rect.width
        let height = rect.height
        let waveLength = width / 2
        
        if isTop {
            // 물 표면의 파도
            path.move(to: CGPoint(x: 0, y: waveHeight))
            
            for x in stride(from: 0, through: width, by: 1) {
                let relativeX = x / waveLength
                let sine = sin(relativeX * .pi + offset)
                let y = waveHeight + (sine * waveHeight)
                path.addLine(to: CGPoint(x: x, y: y))
            }
            
            path.addLine(to: CGPoint(x: width, y: height))
            path.addLine(to: CGPoint(x: 0, y: height))
        } else {
            // 기존 방식 (아래에서 위로)
            path.move(to: CGPoint(x: 0, y: height))
            
            for x in stride(from: 0, through: width, by: 1) {
                let relativeX = x / waveLength
                let sine = sin(relativeX * .pi + offset)
                let y = height - waveHeight - (sine * waveHeight)
                path.addLine(to: CGPoint(x: x, y: y))
            }
            
            path.addLine(to: CGPoint(x: width, y: height))
            path.addLine(to: CGPoint(x: 0, y: height))
        }
        
        path.closeSubpath()
        
        return path
    }
}
