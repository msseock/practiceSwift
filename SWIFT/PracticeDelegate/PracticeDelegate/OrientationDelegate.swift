//
//  OrientationDelegate.swift
//  PracticeDelegate
//
//  Created by 석민솔 on 7/11/25.
//

import Foundation

/// 대리가 해야 할 일의 규약
protocol OrientationDelegate {
    func prepareOrientation()
}

/// 대리 클래스
class AssistantManager: OrientationDelegate {
    func prepareOrientation() {
        print("회의실 예약하고, 교육자료 준비하고, 명단 정리 완료!")
        // 보고하기()
    }
}

/// 과장 클래스: 대부분의 경우, 이 위임하는 클래스는 애플쪽에서 구현해서 가려져있음
class Manager {
    var delegate: OrientationDelegate?
    
    func assignOrientationTask() {
        print("신입 오리엔테이션 준비를 부탁해")
        delegate?.prepareOrientation()
    }
}
