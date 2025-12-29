//
//  ContentView.swift
//  PracticeURLSession
//
//  Created by 석민솔 on 8/20/25.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var router = Router<Route>()
    @ObservedObject var errorManager = ErrorManager.shared
    
    var body: some View {
        NavigationStack(path: $router.paths) {
            if !errorManager.hasError {
                RiverStageListView()
                    .navigationDestination(for: Route.self) { path in
                        switch path {
                        case .list:
                            RiverStageListView()
                        case .riverInfo(let name):
                            RiverInfoView(name: name)
                        case .error(let error):
                            ErrorView(errorType: error)
                        }
                    }
                    .environmentObject(router)
            } else {
                ErrorView(errorType: errorManager.currentError ?? .serverError)
            }
        }
    }
}

#Preview {
    ContentView()
}
