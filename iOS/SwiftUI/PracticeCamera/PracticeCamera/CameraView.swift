//
//  CameraView.swift
//  PracticeCamera
//
//  Created by 석민솔 on 7/1/25.
//

import SwiftUI

// MARK: - CameraViewControllerRepresentable
struct CameraView: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> CameraViewController {
        return CameraViewController()
    }

    func updateUIViewController(_ uiViewController: CameraViewController, context: Context) {
        // 필요에 따라 UIViewController 업데이트 로직 추가
    }

    // MARK: - Coordinator (선택 사항: 델리게이트 패턴 처리 시 사용)
    // func makeCoordinator() -> Coordinator {
    //     Coordinator(self)
    // }
    // class Coordinator: NSObject {
    //     var parent: CameraView
    //     init(_ parent: CameraView) {
    //         self.parent = parent
    //     }
    // }
}

