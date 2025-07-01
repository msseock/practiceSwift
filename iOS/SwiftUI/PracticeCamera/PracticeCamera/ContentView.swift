//
//  ContentView.swift
//  PracticeCamera
//
//  Created by 석민솔 on 7/1/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
            ZStack {
                VStack {
                    // 1. 카메라 뷰파인더 (UIKit을 SwiftUI로 래핑)
                    CameraView()
                        .edgesIgnoringSafeArea(.top) // 화면 전체를 사용하도록 설정
                        .frame(height: UIScreen.main.bounds.height-200)
                    
                    Spacer()
                }

                // 2. 오버레이할 PNG 이미지 or 사각형
                // 일단 PNG 이미지는 주석처리해둠
//                Image("overlay_image") // "overlay_image.png" 파일을 Assets.xcassets에 추가해야 합니다.
//                    .resizable() // 이미지 크기 조절 가능하게
//                    .scaledToFit() // 원본 비율을 유지하며 화면에 맞춤 (또는 .scaledToFill)
//                    .frame(width: UIScreen.main.bounds.width-100, height: UIScreen.main.bounds.height) // 화면 크기에 맞춤
//                    // .frame(maxWidth: .infinity, maxHeight: .infinity) // 다른 방법
//                    .allowsHitTesting(false) // 오버레이 이미지가 터치 이벤트를 가로채지 않도록 설정
                
                Rectangle()
                    .fill(Color.green.opacity(0.2))
                    .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height-450)

                // 3. (선택 사항) 다른 UI 컨트롤 (예: 녹화 버튼)
                VStack {
                    Spacer() // 이미지를 위로 밀어 올리고 아래에 버튼 배치
                    Button(action: {
                        // 녹화 시작/중지 로직 (CameraViewController 내부에 구현하거나 Coordinator를 통해 통신)
                        print("녹화 버튼 탭됨")
                    }) {
                        Text("녹화")
                            .font(.headline)
                            .foregroundColor(.blue)
                            .cornerRadius(10)
                    }
                    .padding(.bottom, 30)
                }
            }
            .onAppear {
                // 앱 시작 시 카메라 권한 요청 (필요 시점에 호출)
                CameraViewController().requestCameraPermission()
            }
        }
}

#Preview {
    ContentView()
}
