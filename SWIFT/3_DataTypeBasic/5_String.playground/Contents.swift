// 상수로 선언된 문자열은 변경이 불가능
let name: String = "sol"

// 이니셜라이저를 사용하여 빈 문자열을 생성
var introduce: String = String()

// append() method 사용하여 문자열 이어붙이기
introduce.append("제 이름은")

// + 연산자 사용하여 문자열 이어붙이기
introduce = introduce + " " + name + "입니다"
print(introduce)

// name에 해당하는 문자의 수를 셀 수 있음
print("name의 글자 수: \(name.count)")

// 빈 문자열인지 확인
print("introduce가 비어있습니까?: \(introduce.isEmpty)")

// 유니코드의 스칼라값을 사용해 해당 표현 출력
let unicodeScalarValue: String = "\u{2665}"

// 연산자를 통한 문자열 결합
let hello: String = "Hello"
let sol: String = "sol"
var greeting: String = hello + " " + sol + "!"
print(greeting)

greeting = hello
greeting += " "
greeting += sol
greeting += "!"
print(greeting)

// 연산자를 통한 문자열 비교
var isSameString: Bool = false

isSameString = hello == "Hello"
print(isSameString) // true

isSameString = hello == "hello"
print(isSameString) // false

isSameString = sol == "sol"
print(isSameString) // true

isSameString = sol == hello
print(isSameString) // false


// 메서드를 통한 접두어, 접미어 확인
var hasPrefix:Bool = false
hasPrefix = hello.hasPrefix("He")
print(hasPrefix)    // true

hasPrefix = hello.hasPrefix("HE")
print(hasPrefix)    // false

hasPrefix = greeting.hasPrefix("Hello ")
print(hasPrefix)    // true

hasPrefix = sol.hasPrefix("los")
print(hasPrefix)    // false

var hasSuffix: Bool = false
hasSuffix = hello.hasSuffix("He")
print(hasSuffix)    // false

hasSuffix = hello.hasSuffix("llo")
print(hasSuffix)    // true

hasSuffix = greeting.hasSuffix("sol")
print(hasSuffix)    // false

hasSuffix = greeting.hasSuffix("sol!")
print(hasSuffix)    // ture

hasSuffix = sol.hasSuffix("ol")
print(hasSuffix)    // true


// 메서드를 통한 대소문자 변환
var convertedString: String = ""
convertedString = hello.uppercased()
print(convertedString)  // HELLO

convertedString = hello.lowercased()
print(convertedString)  // hello

convertedString = sol.uppercased()
print(convertedString)  // SOL

convertedString = greeting.uppercased()
print(convertedString)  // HELLO SOL!

convertedString = greeting.lowercased()
print(convertedString)  // hello sol!


// 프로퍼티를 통한 빈 문자열 확인
var isEmptyString: Bool = false
isEmptyString = greeting.isEmpty
print(isEmptyString)    // false

greeting = "안녕"
isEmptyString = greeting.isEmpty
print(isEmptyString)    // false

greeting = ""
isEmptyString = greeting.isEmpty
print(isEmptyString)    // true


// 프로퍼티를 통해 문자열 길이 확인
print(greeting.count)   // 0

greeting = "안녕하세요"
print(greeting.count)   // 5

greeting = "안녕!"
print(greeting.count)   // 3

// 코드 상에서 여러 줄의 문자열을 직접 쓰고 싶다면 큰따옴표 세 개 사용
// 큰따옴표 세 개 써주고 한 줄 내려써야 함
greeting = """
안녕하세요 저는 감자입니다.
스위프트 잘하고 싶어요! 진짜에요!
잘 부탁합니다!
"""

// MARK: 특수문자
print("문자열 내부에\n 이런 \"특수문자\"를\t사용하면 \\이런 놀라운 결과를 볼 수 있습니다")
print(#"문자열 내부에서 특수문자를 사용하기 싫다면 문자열 앞, 뒤에 #을 붙여주세요우"#)
let number:Int = 100
print(#"특수문자를 사용하지 않을 때도 문자열 보간법을 사용하고 싶다면 이렇게 \#(number) 해보세요"#)
