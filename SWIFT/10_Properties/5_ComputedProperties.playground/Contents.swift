struct CoordinatePoint {
    var x: Int  // 저장 프로퍼티
    var y: Int  // 저장 프로퍼티
    
    // 대칭 좌표
    var oppositePoint: CoordinatePoint {    // 연산 프로퍼티
        // getter
        get {
            return CoordinatePoint(x: -x, y: -y)
        }
        
        // setter
        set(opposite) {
            x = -opposite.x
            y = -opposite.y
        }
    }
}

var msPosition: CoordinatePoint = CoordinatePoint(x: 10, y: 20)

// 현재 좌표
print(msPosition)               // 10, 20

// 대칭 좌표
print(msPosition.oppositePoint) // -10, -20

// 대칭 좌표를 (15, 10)으로 설정하면
msPosition.oppositePoint = CoordinatePoint(x: 15, y: 10)

// 현재 좌표는 -15, -10으로 설정됨
print(msPosition)            // -15, -10
