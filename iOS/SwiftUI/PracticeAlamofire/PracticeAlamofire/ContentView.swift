//
//  ContentView.swift
//  PracticeAlamofire
//
//  Created by 석민솔 on 7/19/24.
//

import SwiftUI

struct ContentView: View {
    let translateService: TranslateService = .init()
    @State var text: String = ""
    
    var body: some View {
        
        VStack(spacing: 20) {
            TextField("번역할 텍스트를 입력하세요", text: $text)
            
            Button {
                translateService.translateText(text: text)
            } label: {
                Text("translate")
            }
            
            Text("your text: \(text)")
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
