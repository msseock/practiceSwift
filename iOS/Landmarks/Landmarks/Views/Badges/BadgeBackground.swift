//
//  BadgeBackground.swift
//  Landmarks
//
//  Created by 석민솔 on 1/16/24.
//

import SwiftUI

struct BadgeBackground: View {
    var body: some View {
        // Wrap the path in a GeometryReader so the badge can use the size of its containing view, which defines the size instead of hard-coding the value (100).
        GeometryReader { geometry in
            Path { path in
                var width: CGFloat = min(geometry.size.width, geometry.size.height)
                let height = width
                
                // Scale the shape on the x-axis using xScale
                let xScale: CGFloat = 0.832
                // xOffset to recenter the shape within its geometry.
                let xOffset = (width * (1.0 - xScale)) / 2.0
                
                width *= xScale
                
                path.move(
                    to: CGPoint(
                        x: width * 0.95 + xOffset,
                        y: height * (0.20 + HexagonParameters.adjustment)
                    )
                )
                
                HexagonParameters.segments.forEach { segment in
                    path.addLine(
                        to: CGPoint(
                            x: width * segment.line.x + xOffset,
                            y: height * segment.line.y
                        )
                    )
                    
                    path.addQuadCurve(
                        to: CGPoint(
                            x: width * segment.curve.x + xOffset,
                            y: height * segment.curve.y
                        ),
                        control: CGPoint(
                            x: width * segment.control.x + xOffset,
                            y: height * segment.control.y))
                }
            }
            .fill(.linearGradient(
                Gradient(colors: [Self.gradientStart, Self.gradientEnd]),
                startPoint: UnitPoint(x: 0.5, y: 0),
                endPoint: UnitPoint(x: 0.5, y: 0.6)
            ))
        }
        // By preserving a 1:1 aspect ratio, the badge maintains its position at the center of the view, even if its ancestor views aren’t square.
        .aspectRatio(1, contentMode: .fit)
    }
    static let gradientStart = Color(red: 239.0 / 255, green: 120.0 / 255, blue: 221.0 / 225)
    static let gradientEnd = Color(red: 239.0 / 255, green: 172.0 / 255, blue: 120.0 / 225)
}

#Preview {
    BadgeBackground()
}
