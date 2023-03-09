// MARK: 필터 메소드의 사용
let numbers: [Int] = [0, 1, 2, 3, 4, 5]

var evenNumbers: [Int] = numbers.filter { (number: Int) -> Bool in
    return number % 2 == 0
}
print(evenNumbers)  // [0, 2, 4]

var oddNumbers: [Int] = numbers.filter { $0 % 2 == 1 }
print(oddNumbers)   // [1, 3, 5]

// MARK: 맵과 필터 메서드의 연계 사용
let mappedNumbers: [Int] = numbers.map { $0 + 3 }

evenNumbers = mappedNumbers.filter { (number: Int) -> Bool in
    return number % 2 == 0
}
print(evenNumbers)  // [4, 6, 8]

// mappedNumbers를 굳이 여러 번 사용할 필요가 없다면 메서드를 체인처럼 연결하여 사용할 수 있음
oddNumbers = numbers.map{ $0 + 3 }.filter{ $0 % 2 == 1 }
print(oddNumbers)   // [3, 5, 7]
