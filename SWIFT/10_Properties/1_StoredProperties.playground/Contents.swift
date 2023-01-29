// MARK: 저장 프로퍼티의 선언 및 인스턴스 생성
// 좌표
struct CoordinatePoint {
    var x: Int  // 저장 프로퍼티
    var y: Int  // 저장 프로퍼티
}

// 구조체에는 기본적으로 저장 프로퍼티를 매개변수로 갖는 이니셜라이저가 있음
let msPoint: CoordinatePoint = CoordinatePoint(x: 10, y: 5)

// 사람의 위치 정보
class Position {
    var point: CoordinatePoint  // 저장 프로퍼티(변수) - 위치(point)는 변경될 수 있음을 뜻함
    let name: String            // 저장 프로퍼티(상수)
    
    // 프로퍼티 기본값을 지정해주지 않는다면 이니셜라이저를 따로 정의해주어야 함
    init(name: String, currentPoint: CoordinatePoint) {
        self.name = name
        self.point = currentPoint
    }
}

// 사용자 정의 이니셜라이저를 호출해야만 함
// 그렇지 않으면 프로퍼티 초깃값을 할당할 수 없기 때문에 인스턴스 생성이 불가능
let msPosition: Position = Position(name: "msseock", currentPoint: msPoint)
