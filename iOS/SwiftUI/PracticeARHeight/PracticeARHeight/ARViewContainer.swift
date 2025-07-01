//
//  ARViewContainer.swift
//  PracticeARHeight
//
//  Created by 석민솔 on 7/1/25.
//

import ARKit
import SwiftUI

// ARSCNView를 SwiftUI에서 사용하기 위한 래퍼
struct ARViewContainer: UIViewRepresentable {
    
    @Binding var measuredHeight: Float
    @Binding var isOriginSet: Bool

    func makeUIView(context: Context) -> ARSCNView {
        let arView = ARSCNView(frame: .zero)
        // 코디네이터를 ARSCNView의 델리게이트로 설정
        arView.delegate = context.coordinator
        
        let configuration = ARWorldTrackingConfiguration()
        configuration.planeDetection = .horizontal
        
        arView.session.run(configuration)
        
        return arView
    }

    func updateUIView(_ uiView: ARSCNView, context: Context) {}

    func makeCoordinator() -> Coordinator {
        Coordinator(measuredHeight: $measuredHeight, isOriginSet: $isOriginSet)
    }

    // ARSCNView의 델리게이트 역할을 하는 코디네이터
    class Coordinator: NSObject, ARSCNViewDelegate {
        @Binding var measuredHeight: Float
        @Binding var isOriginSet: Bool
        
        init(measuredHeight: Binding<Float>, isOriginSet: Binding<Bool>) {
            _measuredHeight = measuredHeight
            _isOriginSet = isOriginSet
        }
        
        // 새로운 AR 앵커(평면 등)가 씬에 추가되었을 때 호출됨
        func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
            // 원점이 아직 설정되지 않았고, 감지된 앵커가 평면 앵커일 경우
            guard !isOriginSet, let planeAnchor = anchor as? ARPlaneAnchor else { return }
            
            // ✅ 수정된 부분: renderer를 통해 session에 접근합니다.
            if let arView = renderer as? ARSCNView {
                arView.session.setWorldOrigin(relativeTransform: planeAnchor.transform)
            }
            
            // 원점이 설정되었음을 앱에 알림
            DispatchQueue.main.async {
                self.isOriginSet = true
            }
        }
        
        // AR 프레임이 업데이트될 때마다 호출됨 (ARSCNViewDelegate는 ARSessionDelegate를 포함)
        func renderer(_ renderer: SCNSceneRenderer, didUpdate node: SCNNode, for anchor: ARAnchor) {
            guard isOriginSet else { return }
            
            // 현재 카메라 프레임 가져오기
            guard let frame = (renderer as? ARSCNView)?.session.currentFrame else { return }
            guard case .normal = frame.camera.trackingState else { return }
            
            let cameraPosition = frame.camera.transform.columns.3
            let height = cameraPosition.y
            
            DispatchQueue.main.async {
                self.measuredHeight = height
            }
        }
    }
}
