//
//  CategoryHome.swift
//  Landmarks
//
//  Created by 석민솔 on 1/17/24.
//

import SwiftUI

struct CategoryHome: View {
    @Environment(ModelData.self) var modelData
    @State private var showingProfile = false
    
    var body: some View {
        NavigationSplitView {
            // Display the categories in Landmarks using a List
            List {
                // add the image of the first featured landmark to the top of the list
                modelData.features[0].image
                    .resizable()
                    .scaledToFill()
                    .frame(height: 200)
                    .clipped()
                    // Set the edge insets to zero so the content can extend to the edges of the display
                    .listRowInsets(EdgeInsets())
                
                // Display the categories in Landmarks using a list
                ForEach(modelData.categories.keys.sorted(), id: \.self) { key in
                    CategoryRow(categoryName: key, items: modelData.categories[key]!)
                }
                .listRowInsets(EdgeInsets())
            }
            .listStyle(.inset)
            .navigationTitle("Featured")
            // 네비게이션 바에 툴바 추가
            .toolbar {
                Button {
                    showingProfile.toggle()
                } label: {
                    Label("User Profile", systemImage: "person.crop.circle")
                }
            }
            // showingProfile값에 따라 사용자 프로필을 표시하는 페이지가 밑에서 튀어나옴
            .sheet(isPresented: $showingProfile) {
                ProfileHost()
                    .environment(modelData)
            }
        } detail: {
            Text("Select a Landmark")
        }
    }
}

#Preview {
    CategoryHome()
        .environment(ModelData())
}
