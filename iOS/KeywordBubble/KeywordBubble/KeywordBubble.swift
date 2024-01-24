//
//  KeywordBubble.swift
//  KeywordBubble
//
//  Created by 석민솔 on 1/24/24.
//

import SwiftUI

struct KeywordBubbleDefaultPadding: View {
    let keyword: String
    let symbol: String
    @ScaledMetric(relativeTo: .title) var paddingWidth = 14.5
    
    var body: some View {
        Label(keyword, systemImage: symbol)
            .font(.title)
            .foregroundColor(.white)
            .padding(paddingWidth)
            .background(.purple.opacity(0.75), in: Capsule())
    }
}

struct KeywordBubbleDefaultPadding_previews: PreviewProvider {
    static let keywords = ["chives", "fern-leaf lavender"]
    static var previews: some View {
        VStack {
            ForEach(keywords, id: \.self) { word in
                KeywordBubbleDefaultPadding(keyword: word, symbol: "leaf")
            }
        }
    }
}
