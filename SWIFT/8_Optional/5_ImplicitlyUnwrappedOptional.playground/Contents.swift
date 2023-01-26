// 암시적 추출 옵셔널의 사용
var myName: String! = "msseock"
print(myName)   // msseock
myName = nil

// 암시적 추출 옵셔널도 옵셔널이므로 바인딩 사용할 수 있음
if let name = myName {
    print("My name is \(name)")
} else {
    print("myName == nil")
}

// myName == nil

//myName.isEmpty // 오류!
