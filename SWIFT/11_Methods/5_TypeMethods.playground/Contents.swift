// MARK: 클래스의 타입 메서드
class AClass {
    static func staticTypeMethod() {
        print("AClass staticTypeMethod")
    }
    
    class func classTypeMethod() {
        print("AClass classTypeMethod")
    }
}

class BClass: AClass {
    /*
     // 오류 발생! 재정의 불가
     override static func staticTypeMethod() {
     
     }
     */
    override class func classTypeMethod() {
        print("BClass classTypeMethod")
    }
}

AClass.staticTypeMethod()   // AClass staticTypeMethod
AClass.classTypeMethod()    // AClass classTypeMethod
BClass.classTypeMethod()    // BClass classTypeMethod

// MARK: 타입 프로퍼티와 타입 메서드의 사용

// 시스템 음량은 한 기기에서 유일한 값이어야 함
struct SystemVolume {
    // 타입 프로퍼티를 사용하면 언제나 유일한 값이 됨
    static var volume: Int = 5
    
    // 타입 프로퍼티를 제어하기 위해 타입 메서드를 사용
    static func mute() {
        self.volume = 0     // SystemVolume.volume = 0 과 같은 표현
                            // Self.volume = 0 과도 같은 표현
    }
}

// 내비게이션 역할은 여러 인스턴스가 수행할 수 있음
class Navigation {
    
    // 내비게이션 인스턴스마다 음량을 따로 설정할 수 있음
    var volume: Int = 5
    
    // 길 안내 음성 재생
    func guideWay() {
        // 내비게이션 외 다른 재생원 음소거
        SystemVolume.mute()
    }
    
    // 길 안내 음성 종료
    func finishGuideWay() {
        // 기존 재생원 음량 복구
        SystemVolume.volume = self.volume
    }
}

SystemVolume.volume = 10

let myNavi: Navigation = Navigation()

myNavi.guideWay()
print(SystemVolume.volume)  // 0

myNavi.finishGuideWay()
print(SystemVolume.volume)  // 5
