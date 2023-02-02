// 상수 프로퍼티의 초기화
class Person {
    let name: String
    var age: Int?
    
    init(name: String) {
        self.name = name
    }
}

let msseock: Person = Person(name: "msseock")
msseock.name = "Eric"   // 오류
