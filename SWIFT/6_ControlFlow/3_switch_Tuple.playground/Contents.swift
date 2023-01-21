// 튜플 switch case 구성
typealias NameAge = (name:String, age:Int)

let tupleValue: NameAge = ("msseock", 21)

switch tupleValue {
case ("msseock", 21):
    print("correct!")
default:
    print("who do you looking for?")
}

// correct!

// 와일드카드 식별자(_)를 사용한 튜플 switch case 구성
switch tupleValue {
case ("msseock", 50):
    print("정확히 맞췄습니다!")
case ("msseock", _):
    print("이름만 맞았습니다. 나이는 \(tupleValue.age)입니다.")
case (_, 21):
    print("나이만 맞았습니다. 이름은 \(tupleValue.name)입니다.")
default:
    print("누굴 찾나요?")
}

// 이름만 맞았습니다. 나이는 21입니다.

// 값 바인딩을 사용한 튜플 switch case 구성
switch tupleValue {
case ("msseock", 50):
    print("correct!")
case("msseock", let age):
    print("이름만 맞았습니다. 나이는 \(age)입니다.")
case(let name, 21):
    print("나이만 맞았습니다. 이름은 \(name)입니다.")
default:
    print("누굴 찾나요?")
}

// 이름만 맞았습니다. 나이는 21입니다.
