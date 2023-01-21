// if 구문 기본 구현
let first: Int = 5
var second: Int = 7

if first > second {
    print("first > second")
} else if first < second {
    print("first < second")
} else {
    print("first == second")
}

// 결과는 "first < second"가 출력

// if 구문의 다양한 구현(소괄호가 없는 코드)
second = 5
var biggerValue: Int = 0

if first > second { // 조건 수식을 소괄호로 묶어주는 것은 선택사항
    biggerValue = first
} else if first == second {
    biggerValue = first
} else if first < second {
    biggerValue = second
} else if first == 5 {
    // 조건을 충족하더라도 이미 first == second라는 조건을 충족해 위에서 실행되었으므로 실행되지 않는다
    biggerValue = 100
}
// 마지막 else, else if는 생략 가능(if만 단독으로 사용 가능)

print(biggerValue)  // 5

// if 구문의 다양한 구현(소괄호가 있는 코드)
biggerValue = 0

if (first > second) {
    biggerValue = first
} else if (first == second) {
    biggerValue = first
} else if (first < second) {
    biggerValue = second
} else if (first == 5) {
    // 이미 조건을 충족해서 실행되지 않는 코드
    biggerValue = 100
}

print(biggerValue)  // 5
