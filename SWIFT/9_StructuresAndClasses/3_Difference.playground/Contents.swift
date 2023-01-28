// 값 타입과 참조 타입의 차이

// 값 타입: 구조체
struct BasicInformation {
    let name: String
    var age: Int
}

var yagomInfo: BasicInformation = BasicInformation(name: "yagom", age: 99)
yagomInfo.age = 100

// yagomInfo의 값을 복사해서 할당
var friendInfo: BasicInformation = yagomInfo

print("yagom's age: \(yagomInfo.age)")      // 100
print("friend's age: \(friendInfo.age)")    // 100

friendInfo.age = 999

print("yagom's age: \(yagomInfo.age)")      // 100 - yagom의 값은 변동 없음
print("friend's age: \(friendInfo.age)")    // 999 - frindInfo는 yagomInfo의 값을 복사해왔기 때문에 별개의 값을 가짐


// 참조 타입: 클래스
class Person {
    var height: Float = 0.0
    var weight: Float = 0.0
}

var yagom: Person = Person()
var friend: Person = yagom      // yagom의 참조를 할당

print("yagom's height: \(yagom.height)")        // 0.0
print("friend's height: \(friend.height)")      // 0.0

friend.height = 188.8
print("yagom's height: \(yagom.height)")
// 188.8 - friend는 yagom을 참조하기 때문에 값이 변동됨

print("friend's height: \(friend.height)")
// 188.8 - yagom이 참조하는 곳과 friend가 참조하는 곳이 같음

// 함수 비교
func changeBasicInfo(_ info: BasicInformation) {
    var copiedInfo: BasicInformation = info
    copiedInfo.age = 1
}

func changePersonInfo(_ info: Person) {
    info.height = 155.3
}

// changeBasicInfo(_:)로 전달되는 전달인자는 값이 복사되어 전달되기 때문에 yagomInfo의 값만 전달됨
changeBasicInfo(yagomInfo)
print("yagom's age: \(yagomInfo.age)")  // 100

// changePersonInfo(_:)의 전달인자로 yagom의 참조가 전달되었기 때문에 yagom이 참조하는 값들에 변화가 생김
changePersonInfo(yagom)
print("yagom's height: \(yagom.height)")    // 155.3


// MARK: 식별 연산자의 사용
let anotherFriend: Person = Person()

print(yagom === friend)             // true
print(yagom === anotherFriend)      // false
print(friend !== anotherFriend)     // true
