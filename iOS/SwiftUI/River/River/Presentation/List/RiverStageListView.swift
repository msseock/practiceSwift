//
//  RiverStageListView.swift
//  PracticeURLSession
//
//  Created by 석민솔 on 8/20/25.
//

import SwiftUI

struct RiverStageListView: View {
    
    @EnvironmentObject var router: Router<Route>
    @StateObject var vm = RiverStageListViewModel()
    
    var body: some View {
        VStack {
            Group {
                Button {
                    Task {
                        await vm.fetchError()
                    }
                } label: {
                    Image(systemName: "xmark.octagon.fill")
                        .font(.title)
                        .foregroundStyle(.red)
                        .frame(maxWidth: .infinity, alignment: .trailing)
                }
                
                Text("하천 정보 보기")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            .padding(.horizontal, 22)
            
            List {
                ForEach(vm.riversList, id: \.self) { river in
                    Button {
                        router.push(.riverInfo(name: river))
                    } label : {
                        HStack {
                            Text(river)
                                .contentShape(Rectangle())
                            
                            Spacer()
                            
                            Image(systemName: "chevron.right")
                                .fontWeight(.semibold)
                                .foregroundStyle(.black.opacity(0.2))
                        }
                        .padding(.vertical, 12)
                    }
                }
            }
            .listStyle(.plain)
        }
        .onAppear {
            Task {
                await vm.fetchRiverListInfo()
            }
        }
    }
}

#Preview {
    RiverStageListView()
}
