//
//  FunFactsView.swift
//  AboutMe
//
//  Created by 석민솔 on 1/30/24.
//

import SwiftUI

struct FunFactsView: View {
    
    @State private var funFact = ""
    
    var body: some View {
        VStack {
            Text("Fun Facts")
                .font(.largeTitle)
                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
            
            Text(funFact)
                .padding()
                .font(.title)
                .frame(minHeight: 400)
            
            Button(action: {
                funFact = information.funFacts.randomElement()!
            }, label: {
                Text("Show Random Fact")
                    .padding()
                    .foregroundStyle(.white)
                    .background(Color.blue)
                    .cornerRadius(30)
            })
        }
        .padding()
    }
}

#Preview {
    FunFactsView()
}
