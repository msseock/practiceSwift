//
//  RiverInfoView.swift
//  PracticeURLSession
//
//  Created by 석민솔 on 8/20/25.
//

import SwiftUI

struct RiverInfoView: View {
    /// 정보 보여줄 강 이름
    let name: String
    
    @EnvironmentObject var router: Router<Route>
    @StateObject var vm: RiverInfoViewModel = RiverInfoViewModel()
    
    var body: some View {
        ZStack {
            WaterWaveView(waterHeight: vm.waterHeight ?? 0)
            
            Text("물 높이: \(Int(vm.waterHeight ?? 0))m")
                .font(.headline)
                .padding()
        }
        .ignoresSafeArea(edges: .bottom)
        .navigationTitle(name)
        .navigationBarTitleDisplayMode(.large)
        .onAppear {
            Task {
                await vm.fetchRiverInfo(name: name)
            }
        }
    }
}

#Preview {
    RiverInfoView(name: "우이천")
        .environmentObject(Router<Route>())
}
