//
//  ContentView.swift
//  ChooseYourOwnStory
//
//  Created by 석민솔 on 1/30/24.
//

import SwiftUI

struct StoryView: View {
    var body: some View {
        NavigationStack {
            StoryPageView(story: story, pageIndex: 0)
        }
    }
}

#Preview {
    StoryView()
}
