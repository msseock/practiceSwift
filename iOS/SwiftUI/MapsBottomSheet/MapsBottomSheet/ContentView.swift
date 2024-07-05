//
//  ContentView.swift
//  MapsBottomSheet
//
//  Created by 석민솔 on 7/5/24.
//

import SwiftUI

struct ContentView: View {
    // View Properties
    @State private var showSheet: Bool = false
    
    var body: some View {
        TabView {
            ForEach(Tab.allCases, id: \.rawValue) { tab in
                Text(tab.rawValue)
                    .tag(tab)
                    .tabItem {
                        Image(systemName: tab.symbol)
                        Text(tab.rawValue)
                    }
                    .toolbarBackground(.visible, for: .tabBar)
            }
        }
        .task {
            showSheet = true
        }
        .sheet(isPresented: $showSheet) {
            VStack(alignment: .leading, spacing: 10) {
                
            }
            .padding()
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
            .presentationDetents([.height(60), .medium, .large])
            .presentationCornerRadius(25)
            .presentationBackground(.regularMaterial) // 우리 플젝에는 흰색처리해주면 될 것 같음
            .presentationBackgroundInteraction(.enabled(upThrough: .large))
            .interactiveDismissDisabled()
            // Add it inside Sheet View
            .bottomMaskForSheet()
        }
    }
}

#Preview {
    ContentView()
}
