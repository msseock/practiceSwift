// MARK: 사람의 주소 정보 표현 설계

// 호실
class Room {
    var number: Int         // 호실 번호
    
    init(number: Int) {
        self.number = number
    }
}

// 건물
class Building {
    var name: String        // 건물 이름
    var room: Room?         // 호실 정보
    
    init(name: String) {
        self.name = name
    }
}

// 주소
struct Address {
    var province: String        // 광역시/도
    var city: String            // 시/군/구
    var street: String          // 도로명
    var building: Building?     // 건물
    var detailAddress: String?  // 건물 외 상세주소
}

// 사람
class Person {
    var name: String        // 이름
    var address: Address?   // 주소
    
    init(name: String) {
        self.name = name
    }
}

let yagom: Person = Person(name: "yagom")

// 옵셔널 체이닝 문법
let yagomRoomViaOptionalChaining: Int? = yagom.address?.building?.room?.number
// nil
//let yagomRoomViaOptionalChaining: Int = yagom.address!.building!.room!.number
// 오류 발생!

// 옵셔널 바인딩의 사용
var roomNumber: Int? = nil

if let yagomAddress: Address = yagom.address {
    if let yagomBuilding: Building = yagomAddress.building {
        if let yagomRoom: Room = yagomBuilding.room {
            roomNumber = yagomRoom.number
        }
    }
}

if let number: Int = roomNumber {
    print(number)
} else {
    print("Can not find room number")
}

// 옵셔널 체이닝의 사용
if let roomNumber: Int = yagom.address?.building?.room?.number {
    print(roomNumber)
} else {
    print("Can not find room number")
}

// 옵셔널 체이닝을 통한 값 할당 시도
yagom.address?.building?.room?.number = 505
print(yagom.address?.building?.room?.number)    // nil

// 옵셔널 체이닝을 통한 값 할당
yagom.address = Address(province: "충청북도", city: "청주시 청원구", street: "충청대로", building: nil, detailAddress: nil)
yagom.address?.building = Building(name: "곰굴")
yagom.address?.building?.room = Room(number: 0)
yagom.address?.building?.room?.number = 505

print(yagom.address?.building?.room?.number)    // Optional(505)
