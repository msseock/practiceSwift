//
//  TiltManager.swift
//  PracticeARHeight
//
//  Created by 석민솔 on 7/7/25.
//

import Combine
import Foundation

/**
 기기의 기울기 데이터를 관리하고 UI 표시를 위한 오프셋 값을 계산하는 클래스

 `TiltManager`는 `TiltDataCollector`로부터 받은 기울기 데이터를 처리하여
 사용자 정의 기준점 대비 오프셋 값을 실시간으로 계산합니다.

 ## 사용 예시
 ```swift
 let dataCollector = TiltDataCollector()
 let tiltManager = TiltManager(
     properX: 0.0,
     properZ: 0.0,
     dataCollector: dataCollector
 )
 ```

 ## 데이터 플로우
 1. CoreMotion → TiltDataCollector (`gravityX`, `gravityZ`)
 2. TiltDataCollector → TiltManager (`degreeX`, `degreeZ`)
 3. TiltManager → UI (`offsetX`, `offsetZ`)

 ## 주요 기능
 - 실시간 기울기 데이터 수신 및 처리
 - 사용자 정의 기준점 대비 오프셋 계산
 - SwiftUI 뷰에서 바로 사용 가능한 `@Published` 프로퍼티 제공
 */
class TiltManager: ObservableObject {
    
    /// 기준점이 되는 좌우 기울기값
    ///
    /// 이 값을 기준으로 현재 기울기와의 차이를 계산하여 `offsetX`를 구합니다.
    /// 값을 제공하지 않는다면 일반적으로 기기가 수평일 때의 값을 사용합니다.
    let properX: Double
    
    /// 기준점이 되는 앞뒤 기울기값
    ///
    /// 이 값을 기준으로 현재 기울기와의 차이를 계산하여 `offsetZ`를 구합니다.
    /// 값을 제공하지 않는다면 일반적으로 기기가 수평일 때의 값을 사용합니다.
    let properZ: Double
    
    /// 계속 변하는 좌우균형값
    ///
    /// `TiltDataCollector`로부터 실시간으로 업데이트되는 X축 기울기 값입니다.
    /// 값이 변경될 때마다 자동으로 `offsetX`가 재계산됩니다.
    ///
    /// - Note: 이 값은 `TiltDataCollector`의 `gravityX`와 동기화됩니다.
    @Published var degreeX: Double = 0.0 {
        didSet {
            offsetX = Float(degreeX - properX) * 100
        }
    }
    
    /// 계속 변하는 앞뒤기울기
    ///
    /// `TiltDataCollector`로부터 실시간으로 업데이트되는 Z축 기울기 값입니다.
    /// 값이 변경될 때마다 자동으로 `offsetZ`가 재계산됩니다.
    ///
    /// - Note: 이 값은 `TiltDataCollector`의 `gravityZ`와 동기화됩니다.
    @Published var degreeZ: Double = 0.0 {
        didSet {
            offsetZ = Float(degreeZ - properZ) * 100
        }
    }
    
    /// UI 표시용 좌우 오프셋 값
    ///
    /// `degreeX`와 `properX`의 차이에 100을 곱한 값입니다.
    /// SwiftUI 뷰에서 애니메이션이나 위치 조정에 사용할 수 있습니다.
    ///
    /// - Note: 값의 범위는 기울기 정도에 따라 달라질 수 있습니다.
    @Published var offsetX: Float = 0
    
    /// UI 표시용 앞뒤 오프셋 값
    ///
    /// `degreeZ`와 `properZ`의 차이에 100을 곱한 값입니다.
    /// SwiftUI 뷰에서 애니메이션이나 위치 조정에 사용할 수 있습니다.
    ///
    /// - Note: 값의 범위는 기울기 정도에 따라 달라질 수 있습니다.
    @Published var offsetZ: Float = 0
    
    /// Combine 구독을 관리하는 Set
    ///
    /// `TiltDataCollector`의 `@Published` 프로퍼티들을 구독하여
    /// 메모리 누수를 방지하고 적절한 생명주기 관리를 수행합니다.
    private var cancellables = Set<AnyCancellable>()
    
    /// TiltManager 인스턴스를 초기화합니다.
    ///
    /// - Parameters:
    ///   - properX: 기준점이 되는 X축 기울기값. 기본값은 0.0입니다.
    ///   - properZ: 기준점이 되는 Z축 기울기값. 기본값은 0.0입니다.
    ///   - dataCollector: 기울기 데이터를 제공하는 `TiltDataCollector` 인스턴스
    ///
    /// 초기화 과정에서 `dataCollector`의 `gravityX`와 `gravityZ` 값을
    /// 실시간으로 구독하여 `degreeX`와 `degreeZ`에 자동으로 할당합니다.
    ///
    /// ## 중요사항
    /// - `dataCollector`는 이미 초기화되고 데이터 수집이 시작된 상태여야 합니다.
    /// - 초기 오프셋 값은 현재 기울기 값과 기준점의 차이로 계산됩니다.
    init(properX: Double = 0, properZ: Double = 0, dataCollector: TiltDataCollector) {
        self.properX = properX
        self.properZ = properZ
        
        // TiltDataCollector의 gravity 값을 실시간으로 구독
        dataCollector.$gravityX
            .assign(to: \.degreeX, on: self)
            .store(in: &cancellables)
        
        dataCollector.$gravityZ
            .assign(to: \.degreeZ, on: self)
            .store(in: &cancellables)
        
        // 초기 오프셋 값 계산
        self.offsetX = Float(degreeX - properX) * 100
        self.offsetZ = Float(degreeZ - properZ) * 100
    }
}
