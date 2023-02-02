// Person 클래스
class Person {
    var name: String
    var age: Int?
    
    init(name: String) {
        self.name = name
    }
}

let msseock: Person = Person(name: "msseock")
print(msseock.name)     // "msseock"
print(msseock.age)      // nil

msseock.age = 99
print(msseock.age)      // 99

msseock.name = "Eric"
print(msseock.name)     // "Eric"
