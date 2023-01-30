// 저장변수의 감시자와 연산변수
var wonInPocket: Int = 2000 {
    willSet {
        print("주머니의 돈이 \(wonInPocket)원에서 \(newValue)원으로 변경될 예정입니다.")
    }
    
    didSet {
        print("주머니의 돈이 \(oldValue)원에서 \(wonInPocket)원으로 변경되었습니다.")
    }
}


var dollarInPocket: Double {
    get {
        return Double(wonInPocket) / 1000.0
    }
    
    set {
        wonInPocket = Int(newValue * 1000.0)
        print("주머니의 달러를 \(newValue)달러로 변경중입니다.")
    }
}

// 주머니의 돈이 2000원에서 3500원으로 변경될 예정입니다.
// 주머니의 돈이 2000원에서 3500원으로 변경되었습니다.
dollarInPocket = 3.5    // 주머니의 달러를 3.5달러로 변경 중입니다.
