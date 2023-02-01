// Area 구조체와 이니셜라이저, 프로퍼티 기본값 지정
struct Area {
    var squareMeter: Double = 0.0   // 프로퍼티 기본값 할당
    
    init() {
        squareMeter = 0.0   // squareMeter의 초깃값 할당
    }
}

let room: Area = Area()
print(room.squareMeter)     // 0.0
