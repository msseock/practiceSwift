// 사용자 정의 후위 연산자 정의와 함수 구현
postfix operator **

postfix func ** (value: Int) -> Int {
    return value + 10
}

let five: Int = 5
let fivePlusTen: Int = five**

print(fivePlusTen)  // 15

// 전위 연산자와 후위 연산자 동시 사용
prefix operator **

prefix func ** (value: Int) -> Int {
    return value * value
}

let sqrtFivePlusTen: Int = **five**

print(sqrtFivePlusTen)
// 후위 연산자 먼저 수행: (10 + 5) * (10 + 5) == 225
