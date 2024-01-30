//
//  ProfileHost.swift
//  Landmarks
//
//  Created by 석민솔 on 1/20/24.
//

import SwiftUI

struct ProfileHost: View {
    @Environment(\.editMode) var editMode
    @Environment(ModelData.self) var modelData
    @State private var draftProfile = Profile.default
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            HStack {
                if editMode?.wrappedValue == .active {
                    Button("Cancel", role: .cancel) {
                        draftProfile = modelData.profile
                        editMode?.animation().wrappedValue = .inactive
                    }
                }
                Spacer()
                EditButton()
            }
            
            if editMode?.wrappedValue == .inactive {
                // EditButton 안눌러서 editMode 비활성화 되어 있는 상태일 때
                ProfileSummary(profile: modelData.profile)
                
            } else {
                // EditButton 눌러서 editMode가 활성화되면 작동하는 코드
                ProfileEditor(profile: $draftProfile)
                    // 뷰 나타나기 전에 할 액션들
                    .onAppear() {
                        draftProfile = modelData.profile
                    }
                    // 뷰 없어지고 나서 할 액션들
                    .onDisappear() {
                        modelData.profile = draftProfile
                    }
            }
        }
        .padding()
    }
}

#Preview {
    ProfileHost()
        // ProfileHost에서는 Environment 안써도 ChildView인 ProfileSummary에서 사용해서 이부분 추가해줘야 된다고 함
        .environment(ModelData())
}
