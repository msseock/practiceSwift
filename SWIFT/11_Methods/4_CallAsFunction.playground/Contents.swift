// Puppy 구조체에 callAsFunction 메서드 구현
struct Puppy {
    
    var name: String = "멍멍이"
    
    func callAsFunction() {
        print("멍멍")
    }
    
    func callAsFunction(destination: String) {
        print("\(destination)(으)로 달려갑니다")
    }
    
    func callAsFunction(something: String, times: Int) {
        print("\(something)(을)를 \(times)번 반복합니다")
    }
    
    func callAsFunction(color: String) -> String {
        return "\(color) 공"
    }
    
    mutating func callAsFunction(name: String) {
        self.name = name
    }
}

var doggy: Puppy = Puppy()

doggy.callAsFunction()  // 멍멍
doggy()                 // 멍멍

doggy.callAsFunction(destination: "집")   // 집(으)로 달려갑니다
doggy(destination: "뒷동산")               // 뒷동산(으)로 달려갑니다

doggy(something: "재주넘기", times: 3)      // 재주넘기(을)를 3번 반복합니다
print(doggy(color: "무지개색"))             // 무지개색 공

doggy(name: "댕댕이")
print(doggy.name)   // 댕댕이

// cf. 메서드를 호출하는 것 되에 함수 표현으로는 사용할 수 없다
// 잘못된 표현
//let wrongfunction: (String) -> Void = doggy(destination:)
// 맞는 표현
let rightfunction: (String) -> Void = doggy.callAsFunction(destination:)
