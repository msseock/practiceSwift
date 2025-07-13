//
//  MotionManager.swift
//  PracticeARHeight
//
//  Created by 석민솔 on 7/7/25.
//

import CoreMotion

/// CoreMotion 데이터를 관리하고 뷰에 업데이트를 알리는 클래스
class MotionManager: ObservableObject {
    private var motionManager = CMMotionManager()

    /// 좌우균형
    @Published var degreeX: Double = 0.0 {
        didSet {
            offsetX = Float(degreeX - properX) * 100
//            if abs(x) > 0.05 {
//                properx = false
//            } else {
//                properx = true
//            }
        }
    }
    
    @Published var y: Double = 0.0
    
    /// 앞뒤기울기
    @Published var degreeZ: Double = 0.0 {
        didSet {
            offsetZ = Float(degreeZ - properZ) * 100
//            if z < 0.1 || 0.2 < z {
//                properz = false
//            } else {
//                properz = true
//            }
        }
    }
    
    let properX: Double = 0
    let properZ: Double = 0.1
    
    @Published var offsetX: Float = 0
    @Published var offsetZ: Float = 0

    init() {
        // 3. 디바이스 모션 업데이트 시작
        if motionManager.isDeviceMotionAvailable {
            motionManager.deviceMotionUpdateInterval = 1.0 / 10.0 // 1초에 10번
            motionManager.startDeviceMotionUpdates(to: .main) { [weak self] (data, error) in
                guard let self = self, let data = data else { return }

                // 4. gravity 데이터에서 x, y, z값을 가져와 @Published 프로퍼티에 할당
                self.degreeX = data.gravity.x
                self.y = data.gravity.y
                self.degreeZ = data.gravity.z
            }
        }
    }
}
