//
//  PushableStack.swift
//  PracticeNavigationStack
//
//  Created by 석민솔 on 11/11/24.
//

import SwiftUI

struct PushableStack: View {
    @State private var path: [String] = []
    
    func popToRoot() {
        path.removeLast(2)
    }
    
    @State var doPop: Bool = false
    
    var body: some View {
        NavigationStack(path: $path) {
            NavigationLink("for testNavigation", value: ViewName.a.rawValue)
                .navigationTitle("Categories")
                .navigationDestination(for: String.self) { viewname in
                    if viewname == ViewName.a.rawValue {
                        ViewA()
                    } else if viewname == ViewName.b.rawValue {
                        ViewB()
                    } else if viewname == ViewName.c.rawValue {
                        ViewC(popToRootAction: popToRoot)
                    }
                }
        }
        .onChange(of: doPop) { oldValue, newValue in
            if newValue == true {
                popToRoot()
            }
        }
    }
}

#Preview {
    PushableStack()
}




// MARK: 수제
enum ViewName: String {
    case a = "a"
    case b = "b"
    case c = "c"
    case root = "root"
}

struct PushableStack_Previews: PreviewProvider {
    static var previews: some View {
        PushableStack()
    }
}
