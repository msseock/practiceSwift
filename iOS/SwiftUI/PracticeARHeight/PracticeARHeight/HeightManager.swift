//
//  HeightManager.swift
//  PracticeARHeight
//
//  Created by 석민솔 on 7/9/25.
//

import Foundation

/// AR 기반 높이 측정 및 UI 상태를 관리하는 클래스
///
/// 이 클래스는 ARKit에서 측정된 높이 데이터를 받아 비즈니스 로직을 처리하고,
/// UI에 필요한 상태값들을 계산하여 제공합니다.
///
/// ## 주요 기능
/// - 실시간 높이 측정 데이터 처리
/// - 기준 높이와의 차이 계산
/// - UI 오프셋 자동 계산 및 범위 제한
/// - 바닥 감지 상태 관리
///
/// ## 사용법
/// ```swift
/// @StateObject private var heightManager = HeightManager()
///
/// HeightMeasurementARView(
///     measuredHeight: $heightManager.measuredHeight,
///     isGroundFound: $heightManager.isGroundFound
/// )
/// ```
///
/// ## 높이 계산 로직
/// 1. ARKit에서 측정된 높이를 받음
/// 2. 기준 높이(1.1m)와의 차이를 계산
/// 3. UI 표시를 위해 부호 반전 및 cm 단위로 변환
/// 4. 표시 범위를 -90cm ~ +90cm로 제한
class HeightManager: ObservableObject {
    
    /// AR 원점이 바닥을 기준으로 설정되었는지 확인하는 변수
    ///
    /// 이 값이 `true`가 되면 ARKit이 바닥 평면을 성공적으로 감지했음을 의미하며,
    /// 높이 측정이 시작될 수 있습니다.
    @Published var isGroundFound: Bool = false

    /// 측정된 높이를 저장하는 상태 변수 (미터 단위)
    ///
    /// ARKit에서 측정된 실제 높이 값이 설정되며, 값이 변경될 때마다
    /// `offsetY`가 자동으로 재계산됩니다.
    ///
    /// ## 동작 과정
    /// 1. ARKit에서 새로운 높이 값 수신
    /// 2. `didSet`에서 기준 높이와의 차이 계산
    /// 3. UI 표시용 `offsetY` 값 업데이트
    @Published var measuredHeight: Float = 0 {
        didSet {
            // UI에 반영될 수 있도록 -+ 반전, m단위 -> cm 단위로
            offsetY = (measuredHeight - idealHeight) * -1 * 100
        }
    }
    
    /// 현재 높이가 적절한 범위에 있는지 나타내는 상태
    ///
    /// 이 값은 UI에서 사용자에게 높이 조정이 필요한지 알려주는 데 사용됩니다.
    /// 추후 높이 범위 검증 로직이 추가될 수 있습니다.
    @Published var isProperHeight: Bool = true
    
    /// 기준 높이 (미터 단위)
    ///
    /// 사용자가 서 있어야 하는 이상적인 높이값입니다.
    /// 이 값을 기준으로 현재 높이와의 차이를 계산합니다.
    ///
    let idealHeight: Float
    
    /// UI 표시용 오프셋 값 (센티미터 단위)
    ///
    /// 기준 높이와 현재 높이의 차이를 UI에 표시하기 위한 값입니다.
    /// 양수는 기준보다 높음을, 음수는 기준보다 낮음을 의미합니다.
    ///
    /// ## 값 범위
    /// - 최소값: -90cm (기준보다 90cm 낮음)
    /// - 최대값: +90cm (기준보다 90cm 높음)
    ///
    /// ## 계산 공식
    /// ```
    /// offsetY = (measuredHeight - idealHeight) * -1 * 100
    /// ```
    ///
    /// - Parameter measuredHeight: 측정된 높이 (미터)
    /// - Parameter idealHeight: 기준 높이 (미터)
    /// - 부호 반전(-1): UI 표시 방향 조정
    /// - 100 곱하기: 미터를 센티미터로 변환
    @Published var offsetY: Float = 0 {
        didSet {
            // 범위 안에 들어오도록 설정
            if offsetY < -90  {
                offsetY = -90
            } else if offsetY > 90 {
                offsetY = 90
            }
        }
    }
    
    init(idealHeight: Float) {
        self.idealHeight = idealHeight
    }
}
