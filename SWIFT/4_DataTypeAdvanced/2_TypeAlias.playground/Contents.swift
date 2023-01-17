typealias MyInt = Int
typealias YourInt = Int
typealias MyDouble = Double

let age: MyInt = 100        // MyInt는 Int의 또 다른 이름
var year: YourInt = 2000    // YourInt도 Int의 또 다른 이름

// MyInt도, YourInt도 Int이기 때문에 같은 타입으로 취급
year = age

let month: Int = 7          // 기존 Int도 사용 가능
let percentage: MyDouble = 99.9 // Int 외에 다른 자료형도 모두 별칭 사용 가능
