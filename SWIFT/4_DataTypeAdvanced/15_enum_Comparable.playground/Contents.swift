// 비교 가능한 열거형의 사용
enum Condition: Comparable {
    case terrible
    case bad
    case good
    case great
}

let myCondition: Condition = Condition.great
let yourCondition: Condition = Condition.bad

if myCondition >= yourCondition {
    print("제 상태가 더 좋군여")
} else {
    print("당신의 상태가 더 좋군여. 부럽슴다")
}
// 제 상태가 더 좋군요


enum Device: Comparable {
    case iPhone(version: String)
    case iPad(version: String)
    case macBook
    case iMac
}

var devices: [Device] = []
devices.append(Device.iMac)
devices.append(Device.iPhone(version: "14.3"))
devices.append(Device.iPhone(version: "6.1"))
devices.append(Device.iPad(version: "10.3"))
devices.append(Device.macBook)

let sortedDevices: [Device] = devices.sorted()
print(sortedDevices)
