// MARK: 클로저를 이용한 연산 지연
// 대기 중인 손님들
var customersInLine: [String] = ["YoangWha", "SangYong", "SungHun", "HaMi"]
print(customersInLine.count)    // 4

// 클로저를 만들어두면 클로저 내부의 코드를 미리 실행(연산)하지 않고 가지고만 있음
let customerProvider: () -> String = {
    return customersInLine.removeFirst()
}
print(customersInLine.count)    // 4

// 실제 실행
print("Now serving \(customerProvider())!") // "Now serving YoangWha!"
print(customersInLine.count)    // 3

// MARK: 함수의 전달인자로 전달하는 클로저
func serveCustomer(_ customerProvider: () -> String) {
    print("Now serving \(customerProvider())!")
}

serveCustomer( { customersInLine.removeFirst() })   // Now serving YoangWha!

// MARK: 자동 클로저의 사용
func serveCustomer2(_ customerProvider: @autoclosure () -> String) {
    print("Now serving \(customerProvider())!!")
}

serveCustomer2(customersInLine.removeFirst())   // Now serving SungHun!!

// MARK: 자동 클로저의 탈출
customersInLine = ["minjae", "innoceive", "sopress"]

func returnProvider(_ customerProvider: @autoclosure @escaping () -> String) -> (() -> String) {
    return customerProvider
}

let customerProvider2: () -> String = returnProvider(customersInLine.removeFirst())
print("Now serving \(customerProvider2())!")    // Now serving minjae
