// 열거형을 입력 값으로 받는 switch 구문
enum Planet {
    case mercury, venus, earth, mars, jupiter, saturn, urnus, neptune
}

let thisPlanet: Planet = Planet.earth

switch thisPlanet {
case .mercury:
    print("I'm in mercury")
case .venus:
    print("I'm in venus")
case .earth:
    print("I'm in earth")
case .mars:
    print("I'm in mars")
case .jupiter:
    print("I'm in jupiter")
case .saturn:
    print("I'm in saturn")
case .urnus:
    print("I'm in urnus")
case .neptune:
    print("I'm in neptune")
}

// I'm in earth

// Menu 열거형의 모든 case를 처리하는 switch구문의 상태
enum Menu {
    case chicken
    case pizza
}

let lunch: Menu = .chicken

switch lunch {
case .chicken:
    print("반반 무많이!")
case .pizza:
    print("핫소스 많이 주세요")
case _: // case default: 와 같은 표현
    print("오늘 메뉴가 뭐죠?")
}

// 반반 무많이!

// 차후에 Menu 열거형에 추가한 case를 처리하지 않으면 경고를 내어줄 unknown 생성
enum Menu2 {
    case chicken, pizze, hamburger
}

switch lunch {
case .chicken:
    print("반반 무많이~")
case .pizza:
    print("핫소스 많이 주세요~")
@unknown case _:
    print("오늘 메뉴가 모죠?")
}
