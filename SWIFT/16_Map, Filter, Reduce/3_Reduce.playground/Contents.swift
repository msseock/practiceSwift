let numbers: [Int] = [1, 2, 3]

// MARK: 첫 번째 형태인 reduce(_:_:) 메서드의 사용

// 초깃값이 0이고 정수 배열의 모든 값을 더함
var sum: Int = numbers.reduce(0, { (result: Int, next: Int) -> Int in
    print("\(result) + \(next)")
    // 0 + 1
    // 1 + 2
    // 3 + 3
    return result + next
})

print(sum)  // 6

// 초깃값이 0이고 정수 배열의 모든 값을 뺌
let subtract: Int = numbers.reduce(0, { (result: Int, next: Int) -> Int in
    print("\(result) - \(next)")
    // 0 - 1
    // -1 - 2
    // -3 - 3
    return result - next
})

print(subtract) // -6


// 초깃값이 3이고 정수 배열의 모든 값을 더함
let sumFromThree: Int = numbers.reduce(3) {
    print("\($0) + \($1)")
    // 3 + 1
    // 4 + 2
    // 6 + 3
    return $0 + $1
}

print(sumFromThree)         // 9

// 초깃값이 3이고 정수 배열의 모든 값을 뺌
let subtractFromThree: Int = numbers.reduce(3) {
    print("\($0) - \($1)")
    // 3 - 1
    // 2 - 2
    // 0 - 3
    return $0 - $1
}

print(subtractFromThree)    // -3


// 문자열 배열을 reduce(_:_:) 메서드를 이용해 연결시킵니다
let names: [String] = ["Chope", "Jay", "Joker", "Nova"]

let reducedNames: String = names.reduce("msseock's friend: ") {
    return $0 + ", " + $1
}

print(reducedNames) // "msseock's friend: , Chope, Jay, Joker, Nova"
