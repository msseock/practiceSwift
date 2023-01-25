// MARK: 함수 타입의 사용
typealias CalculateTwoInts = (Int, Int) -> Int

func addTwoInts(_ a: Int, _ b: Int) -> Int {
    return a + b
}

func multiplyTwoInts(_ a: Int, _ b: Int) -> Int {
    return a * b
}

var mathFunction: CalculateTwoInts = addTwoInts

// var mathFunction: (Int, Int) -> Int = addTwoInts와 동일한 표현
print(mathFunction(2, 5))   // 2 + 5 = 7

mathFunction = multiplyTwoInts
print(mathFunction(2, 5))   // 2 * 5 = 10

// MARK: 전달인자로 함수를 전달받는 함수
func printMathResult(_ mathFunction: CalculateTwoInts, _ a: Int, _ b: Int) {
    print("Result: \(mathFunction(a, b))")
}

printMathResult(addTwoInts, 3, 5)   // Result: 8


// MARK: 특정 조건에 따라 적절한 함수를 반환해주는 함수
func chooseMathFunction(_ toAdd: Bool) -> CalculateTwoInts {
    return toAdd ? addTwoInts : multiplyTwoInts
}

printMathResult(chooseMathFunction(true), 3, 5)
