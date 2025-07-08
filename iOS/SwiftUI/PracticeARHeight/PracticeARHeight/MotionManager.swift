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

    // 좌우균형
    @Published var x: Double = 0.0 {
        didSet {
            if abs(x) > 0.05 {
                properx = false
            } else {
                properx = true
            }
        }
    }
    
    @Published var y: Double = 0.0
    
    // 앞뒤기울기
    @Published var z: Double = 0.0 {
        didSet {
            if z < 0.1 || 0.2 < z {
                properz = false
            } else {
                properz = true
            }
        }
    }
    
    @Published var properx: Bool = true
    @Published var properz: Bool = true

    init() {
        // 3. 디바이스 모션 업데이트 시작
        if motionManager.isDeviceMotionAvailable {
            motionManager.deviceMotionUpdateInterval = 1.0 / 10.0 // 1초에 10번
            motionManager.startDeviceMotionUpdates(to: .main) { [weak self] (data, error) in
                guard let self = self, let data = data else { return }

                // 4. gravity 데이터에서 x, y, z값을 가져와 @Published 프로퍼티에 할당
                self.x = data.gravity.x
                self.y = data.gravity.y
                self.z = data.gravity.z
            }
        }
    }
}
