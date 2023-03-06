// MARK: guard 구문의 옵셔널 바인딩 활용
func greet(_ person: [String: String]) {
    guard let name: String = person["name"] else {
        return
    }
    
    print("Hello \(name)!")
    
    guard let location: String = person["location"] else {
        print("I hope the weather is nice near you")
        return
    }
    
    print("I hope the weather is nice in \(location)")
}

var personInfo: [String: String] = [String: String]()
personInfo["name"] = "Jenny"

greet(personInfo)
// Hello Jenny!
// I hope the weather is nice near you

personInfo["location"] = "Korea"

greet(personInfo)
// Hello Jenny!
// I hope the weather is nice in Korea


// MARK: guard 구문에 구체적인 조건을 추가
func enterClud(name: String?, age: Int?) {
    guard let name: String = name, let age:Int = age, age > 19, name.isEmpty == false else {
        print("You are too young to enter the club")
        return
    }
    
    print("Welcome \(name)!")
}

// MARK: guard 구문이 사용될 수 없는 경우
let first: Int = 3
let second: Int = 5

//guard first > second  else {
//    // 여기에 들어올 제어문 전환 명령은 딱히 없음. 오류!
//}
