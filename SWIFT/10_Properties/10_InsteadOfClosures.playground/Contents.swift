// MARK: 클로저를 대체할 수 있는 키 경로 표현
struct Person {
    let name: String
    let nickname: String?
    let age: Int
    
    var isAdult: Bool {
        return age > 18
    }
}

let msseock: Person = Person(name: "msseock", nickname: "sol", age: 100)
let hana: Person = Person(name: "hana", nickname: "na", age: 100)
let happy: Person = Person(name: "happy", nickname: nil, age: 3)

let family: [Person] = [msseock, hana, happy]
let names: [String] = family.map(\.name)    // ["msseock", "hana", "happy"]
let nicknames: [String] = family.compactMap(\.nickname) // ["sol", "na"]
let adults: [String] = family.filter(\.isAdult).map(\.name) // ["msseock", "hana"]

// 나중에 클로저 배우면 다시와서 봐야지
