// MARK: 클래스, 구조체, 열거형의 기본적인 형태의 이니셜라이저
class SomeClass {
    init() {
        // 초기화할 때 필요한 코드
    }
}

struct SomeStruct {
    init() {
        // 초기화할 때 필요한 코드
    }
}

enum SomeEnum {
    case someCase
    
    init() {
        // 열거형은 초기화할 때 반드시 case중 하나가 되어야 함
        self = .someCase
        // 초기화할 때 필요한 코드
    }
}
