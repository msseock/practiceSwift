// Person 클래스 정의
class Person {
    var height: Float = 0.0
    var weight: Float = 0.0
    
    deinit {
        print("Person 클래스의 인스턴스가 소멸됩니다.")
    }
}

// Person 클래스의 인스턴스 생성 및 사용
var msseock: Person = Person()
msseock.height = 123.4
msseock.weight = 123.4

let jenny: Person = Person()
jenny.height = 123.4
jenny.weight = 123.4

// Person 클래스의 인스턴스 소멸
var yagom: Person? = Person()
yagom = nil     // Person 클래스의 인스턴스가 소멸됨
