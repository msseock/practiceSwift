// MARK: 실패 가능한 이니셜라이저_클래스
class Person {
    let name: String
    var age: Int?
    
    init?(name: String) {
        if name.isEmpty {
            return nil
        }
        self.name = name
    }
    
    init?(name: String, age: Int) {
        if name.isEmpty || age < 0 {
            return nil
        }
        self.name = name
        self.age = age
    }
}

let msseock: Person? = Person(name: "msseock", age: 99)

if let person: Person = msseock {   // 옵셔널 바인딩
    print(person.name)
} else {
    print("Person wasn't initialized")
}
// msseock


let chope: Person? = Person(name: "chope", age: -10)

if let person: Person = chope {     // 옵셔널 바인딩
    print(person.name)
} else {
    print("Person wasn't initialized")
}
// Person wasn't initialized


let eric: Person? = Person(name: "", age: 30)

if let person:Person = eric {
    print(person.name)
} else {
    print("Person wasn't initialized")
}
// Person wasn't initialized

// MARK: 실패 가능한 이니셜라이저_enum
enum Student: String {
    case elementary = "초등학생", middle = "중학생", high = "고등학생"
    
    init?(koreanAge: Int) {
        switch koreanAge {
        case 8...13:
            self = .elementary
        case 14...16:
            self = .middle
        case 17...19:
            self = .high
        default:
            return nil
        }
    }
    
    init?(bornAt: Int, currentYear: Int) {
        self.init(koreanAge: currentYear - bornAt + 1)
    }
}

var younger: Student? = Student(koreanAge: 20)
print(younger)  // nil

younger = Student(bornAt: 2020, currentYear: 2016)
print(younger)  // nil

younger = Student(rawValue: "대학생")
print(younger)  // nil

younger = Student(rawValue: "고등학생")
print(younger)  // high
