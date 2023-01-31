// MARK: 키 경로 타입의 타입 확인
class Person {
    let name: String
    
    init(name: String) {
        self.name = name
    }
}

struct Stuff {
    var name: String
    var owner: Person
}

print(type(of: \Person.name))   // ReferenceWritableKeyPath<Person, String>
print(type(of: \Stuff.name))    // WritableKeyPath<Stuff, String>

// 키 경로 타입의 경로 연결
let keyPath = \Stuff.owner
let nameKeyPath = keyPath.appending(path: \.name)

// MARK: keyPath 서브스크립트와 키 경로 활용
let msseock = Person(name: "msseock")
let hana = Person(name: "hana")

let macbook = Stuff(name: "MacBook Pro", owner: msseock)
var iMac = Stuff(name: "iMac", owner: msseock)
let iPhone = Stuff(name: "iPhone", owner: hana)

let stuffNameKeyPath = \Stuff.name
let ownerKeyPath = \Stuff.owner

// \Stuff.owner.name과 같은 표현
let ownerNameKeyPath = ownerKeyPath.appending(path: \.name)

// 키 경로와 서브스크립트를 이용해 프로퍼티에 접근해 값을 가져옴
print(macbook[keyPath: stuffNameKeyPath])   // MacBookPro
print(iMac[keyPath: stuffNameKeyPath])      // iMac
print(iPhone[keyPath: stuffNameKeyPath])    // iPhone

print(macbook[keyPath: ownerNameKeyPath])   // msseock
print(iMac[keyPath: ownerNameKeyPath])      // msseock
print(iPhone[keyPath: ownerNameKeyPath])    // hana

// 키 경로와 서브스크립트를 이용해 프로퍼티에 접근하여 값을 변경
iMac[keyPath: stuffNameKeyPath] = "iMac Pro"
iMac[keyPath: ownerKeyPath] = hana

print(iMac[keyPath: stuffNameKeyPath])  // iMacPro
print(iMac[keyPath: ownerNameKeyPath])  // hana

// 상수로 지정한 값 타입과 읽기 전용 프로퍼티는 키 경로 서브스크립트로도 값을 바꿔줄 수 없음
//macbook[keyPath: stuffNameKeyPath] = "macbook pro touch bar"    // error!
//msseock[keyPath: \Person.name] = "bear" // error!
