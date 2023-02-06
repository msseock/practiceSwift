// MARK: 후행 플로저 표현
let names: [String] = ["wizplan", "eric", "yagom", "jenny"]

// 후행 클로저의 사용
let reversed: [String] = names.sorted() { (first: String, second: String) -> Bool in
    return first > second
}

// sorted(by:) 메서드의 소괄호까지 생략 가능
let reversed2: [String] = names.sorted { (first: String, second: String) -> Bool in
    return first > second
}


func doSomething(do: (String) -> Void,
                 onSuccess: (Any) -> Void,
                 onFailure: (Error) -> Void) {
    // do something...
}

// 다중 후행 클로저의 사용
doSomething { (someString: String) in
    // do Closure
} onSuccess: { (result: Any) in
    // success closure
} onFailure: { (error: Error) in
    // failure closure
}
