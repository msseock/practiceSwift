// Float이 수용할 수 있는 범위를 넘어섬
// 자신이 감당할 수 있는 만큼만 남기므로 정확도가 떨어짐
var floatValue: Float = 1234567890.1

// Double은 충분히 수용가능
var doubleValue: Double = 1234567890.1

print("floatValue: \(floatValue), doubleValue: \(doubleValue)")

// Float이 수용할 수 있는 범위의 수로 변경
floatValue = 123456.1
print(floatValue)


// MARK: 부록_random
Int.random(in: -100...100)
UInt.random(in: 1...30)
Double.random(in: 1.5...4.3)
Float.random(in: -0.5...1.5)
