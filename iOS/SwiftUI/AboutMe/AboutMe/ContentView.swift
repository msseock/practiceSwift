//
//  ContentView.swift
//  AboutMe
//
//  Created by 석민솔 on 1/30/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            // Tab1: Home
            HomeView()
                .tabItem {
                    Label("Home", systemImage: "person")
                }
            
            // Tab2: Story
            StoryView()
                .tabItem {
                    Label("Story", systemImage: "book")
                }
            
            // Tab3: Favorites
            FavoritesView()
                .tabItem {
                    Label("Favorites", systemImage: "star")
                }
            
            // Tab4: Fun Facts
            FunFactsView()
                .tabItem {
                    Label("Fun Facts", systemImage: "hand.thumbsup")
                }
        }
    }
}

#Preview {
    ContentView()
}
