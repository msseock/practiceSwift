let names: [String] = ["해린", "민지", "다니엘", "하니", "혜인"]

// MARK: 문맥을 이용한 타입 유추
// 클로저의 매개변수 타입과 반환 타입을 생략하여 표현할 수 있음
let reversed: [String] = names.sorted { (first, second) in
    return first > second
}

// MARK: 단축 인자 이름
let reversed2: [String] = names.sorted {
    return $0 > $1
}

// MARK: 암시적 반환 표현. return 생략 가능
let reversed3: [String] = names.sorted { $0 > $1 }
print(reversed3)

// MARK: 클로저로서의 연산자 함수 사용
let reversed4: [String] = names.sorted(by: >)
