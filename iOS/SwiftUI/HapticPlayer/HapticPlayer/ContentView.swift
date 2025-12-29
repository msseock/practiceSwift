//
//  ContentView.swift
//  HapticPlayer
//
//  Created by 석민솔 on 11/11/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            NavigationLink("한개 테스트") {
                SingleHapticTestView()
            }
            .padding(.vertical)
            
            NavigationLink("패턴 만들기") {
                PatternHapticTestView()
            }
        }
    }

}

#Preview {
    ContentView()
}
