//
//  HeightManager.swift
//  PracticeARHeight
//
//  Created by 석민솔 on 7/9/25.
//

import Foundation

class HeightManager: ObservableObject {
    // AR 원점이 바닥을 기준으로 설정되었는지 확인하는 변수
    @Published var isGroundFound: Bool = false

    // 측정된 높이를 저장하는 상태 변수
    @Published var measuredHeight: Float = 0 {
        didSet {
            if measuredHeight < idealHeight - 0.1 || idealHeight + 0.1 < measuredHeight {
                isProperHeight = false
            } else {
                isProperHeight = true
            }
        }
    }
    
    @Published var isProperHeight: Bool = true
    
    let idealHeight: Float = 1.1
}
