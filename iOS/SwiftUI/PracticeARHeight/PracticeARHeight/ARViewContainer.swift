//
//  ARViewContainer.swift
//  PracticeARHeight
//
//  Created by 석민솔 on 7/1/25.
//

import ARKit
import RealityKit
import SwiftUI

// ARView를 SwiftUI에서 사용하기 위한 래퍼
struct ARViewContainer: UIViewRepresentable {

    @Binding var measuredHeight: Float
    @Binding var isGroundFound: Bool

    func makeUIView(context: Context) -> ARView {
        let arView = ARView(frame: .zero)

        // ARKit 설정
        let configuration = ARWorldTrackingConfiguration()
        configuration.planeDetection = [.horizontal] // 수평 평면인 바닥 감지
        configuration.environmentTexturing = .automatic
        
        arView.session.run(configuration)
        
        // delegate 연결
        arView.session.delegate = context.coordinator
        
        return arView
    }

    func updateUIView(_ uiView: ARView, context: Context) {
        // Coordinator가 SwiftUI에 접근할 수 있도록 연결
        context.coordinator.parent = self
    }
    
    // Coordinator 생성
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, ARSessionDelegate {
        var parent: ARViewContainer
        var groundHeight: Float?
        var detectedPlanes: [ARPlaneAnchor] = []
        
        init(_ parent: ARViewContainer) {
            self.parent = parent
        }
        
        /// ARKit이 새로운 바닥을 발견했을 때 호출
        func session(_ session: ARSession, didAdd anchors: [ARAnchor]) {
            print("새로운 앵커 감지됨: \(anchors.count)개")
            
            for anchor in anchors {
                if let planeAnchor = anchor as? ARPlaneAnchor,
                   planeAnchor.alignment == .horizontal {

                    detectedPlanes.append(planeAnchor)
                    updateGroundHeight()
                    
                    print("바닥 평면 발견) 위치: \(planeAnchor.transform.columns.3.y)")
                    
                    // SwiftUI에 바닥 발견 알림
                    DispatchQueue.main.async {
                        self.parent.isGroundFound = true
                    }
                    
                }
            }
        }
        
        /// 바닥 정보가 업데이트될 때 호출(더 정확해짐)
        func session(_ session: ARSession, didUpdate anchors: [ARAnchor]) {
            var updated = false
            
            for anchor in anchors {
                if let planeAnchor = anchor as? ARPlaneAnchor,
                   planeAnchor.alignment == .horizontal {
                    
                    // 기존 평면 정보 업데이트
                    if let index = detectedPlanes.firstIndex(where: { $0.identifier == planeAnchor.identifier }) {
                        detectedPlanes[index] = planeAnchor
                        updated = true
                    }
                }
            }
            
            if updated {
                updateGroundHeight()
                print("바닥 정보 업데이트됨")
            }
        }
        
        func session(_ session: ARSession, didUpdate frame: ARFrame) {
            guard let groundY = groundHeight else { return }
            
            // 현재 카메라 높이
            let cameraY = frame.camera.transform.columns.3.y
            
            // 높이 계산: 카메라 위치 - 바닥 위치
            let deviceHeight = cameraY - groundY
            
            // SwiftUI에 실시간 높이 업데이트
            DispatchQueue.main.async {
                self.parent.measuredHeight = deviceHeight
            }
        }
        
        // 에러 처리
        func session(_ session: ARSession, didFailWithError error: Error) {
            print("❌ ARSession 에러: \(error.localizedDescription)")
        }
        
        // 세션 중단됨
        func sessionWasInterrupted(_ session: ARSession) {
            print("⏸️ ARSession 중단됨")
        }
        
        // 세션 재개됨
        func sessionInterruptionEnded(_ session: ARSession) {
            print("▶️ ARSession 재개됨")
        }
        
        /// 가장 큰 평면을 바닥으로 간주
        private func updateGroundHeight() {
            guard !detectedPlanes.isEmpty else { return }
            
            // 가장 큰 평면 찾기
            let largestPlane = detectedPlanes.max { plane1, plane2 in
                let area1 = plane1.planeExtent.width * plane1.planeExtent.height
                let area2 = plane2.planeExtent.width * plane2.planeExtent.height
                return area1 < area2
            }
            
            if let plane = largestPlane {
                groundHeight = plane.transform.columns.3.y
                print("가장 큰 평면을 바닥으로 설정: \(groundHeight!) (크기: \(plane.planeExtent.width * plane.planeExtent.height))")
            }
        }
    }
}
