// MARK: 옵셔널 저장 프로퍼티
// 좌표
struct CoordinatePoint {
    // 위치는 x, y 값이 모두 있어야 하므로 옵셔널이면 안됨
    var x: Int
    var y: Int
}

// 사람의 위치 정보
class Position {
    // 현재 사람의 위치를 보를 수도 있음 - 옵셔널
    var point: CoordinatePoint?
    let name: String
    
    init(name: String) {
        self.name = name
    }
}

// 이름은 필수지만 모를 수 있음
let msPosition: Position = Position(name: "msseock")

// 위치를 알게 되면 그 때 위치 값을 할당
msPosition.point = CoordinatePoint(x: 20, y: 10)
