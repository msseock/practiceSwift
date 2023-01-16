var integer: Int = -100
let unsignedInteger: UInt = 50  // UInt 타입에는 음수값을 할당할 수 없음
print("integer 값: \(integer), unsignedInteger 값: \(unsignedInteger)")
print("Int 최댓값: \(Int.max), Int 최솟값: \(Int.min)")
print("UInt 최댓값: \(UInt.max), UInt 최솟값: \(UInt.min)")

let largeInteger: Int64 = Int64.max
let smallUnsignedInteger: UInt8 = UInt8.max
print("Int64 max: \(largeInteger), UInt8 max: \(smallUnsignedInteger)")

//let tooLarge: Int = Int.max + 1 // Int의 표현범위를 초과하므로 오류
//let cannotBeNegetive: UInt = -5 // UInt는 음수가 될 수 없으므로 오류

//integer = unsignedInteger       // 오류! 스위프트에서 Int와 UInt는 다른 타입
integer = Int(unsignedInteger)  // Int 타입의 값으로 할당해주어야 함

// MARK: 진수별 정수 표현
let decimalInteger: Int = 28
let binaryInteger: Int = 0b11100    // 2진수로 10진수 28을 표현
let octalInteger: Int = 0o34        // 8진수로 10진수 28을 표현
let hexadecimalInteger: Int = 0x1c  // 16진수로 10진수 28을 표현
