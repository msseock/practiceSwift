// while 반복 구문의 사용
var names: [String] = ["Joker", "Jenny", "Nova", "msseock"]

while names.isEmpty == false {
    print("Good bye \(names.removeFirst())")
    // removeFirst()는 요소를 삭제함과 동시에 삭제한 요소를 반환
}

// repeat-while

names = ["Joker", "Jenny", "Nova", "msseock"]

repeat {
    print("Good bye \(names.removeFirst())")
} while names.isEmpty == false
