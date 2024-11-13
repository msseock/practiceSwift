//
//  ViewA.swift
//  PracticeNavigationStack
//
//  Created by 석민솔 on 11/11/24.
//

import SwiftUI

struct ViewA: View {
    var body: some View {
        Text("A")
            .font(.largeTitle)
        NavigationLink("Move to B", value: ViewName.b.rawValue)
    }
}

struct ViewB: View {
    var body: some View {
        Text("B")
            .font(.largeTitle)
        NavigationLink("Move to C", value: ViewName.c.rawValue)
    }
}

struct ViewC: View {
    
    let popToRootAction: () -> Void
    
    var body: some View {
        Text("C")
            .font(.largeTitle)
        NavigationLink("Move to A", value: ViewName.a.rawValue)
        
        Button("Pop to A") {
            popToRootAction()
        }
    }
}

#Preview {
    ViewA()
}
