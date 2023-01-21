// switch 구문 기본 구현
let integerValue: Int = 5

switch integerValue {
case 0:
    print("Value == zero")
case 1...10:
    print("Value == 1~10")
    fallthrough
case Int.min..<0, 101..<Int.max:
    print("Value < 0 or Value > 100")
    break
default:
    print("10 < Value <= 100")
}

// 결과
// Value == 1 ~ 10
// Value < 0 or Value > 100

// 부동소수 타입의 범위 연산을 통한 switch case 구성
let doubleValue: Double = 3.0

switch doubleValue {
case 0:
    print("Value == zero")
case 1.5 ... 10.5:
    print("1.5 <= Value <= 10.5")
default:
    print("Value == \(doubleValue)")
}

// 1.5 <= Value <= 10.5

// 문자열 switch case 구성
var stringValue: String = "Harry Styles"

switch stringValue {
case "sol":
    print("She is sol")
case "Jay":
    print("He is Jay")
case "Jenny", "Joker", "Carol":
    print("He or She is \(stringValue)")
default:
    print("\(stringValue) said 'See you soon Korea!'")
}

// Harry Styles said 'See you soon Korea!'

// fallthrough의 사용
stringValue = "Joker"

switch stringValue {
case "yagom":
    print("He is yagom")
case "Jay":
    print("He is Jay")
case "Jenny":
    fallthrough
case "Joker":
    fallthrough
case "Nova":
    print("He or She is \(stringValue)")
default:
    print("\(stringValue) said 'I don't know who you are.'")
}

// He or She is Joker

