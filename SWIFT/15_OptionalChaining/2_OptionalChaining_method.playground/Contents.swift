// MARK: 옵셔널 체이닝을 통한 메서드 호출

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
    var province: String            // 광역시/도
    var city: String                // 시/군/구
    var street: String              // 도로명
    var building: Building?           // 건물
    var detailAddress: String?      // 건물 외 상세주소
    
    init(province: String, city: String, street: String) {
        self.province = province
        self.city = city
        self.street = street
    }
    
    // (수정) 메서드 내부에서 guard 구문의 옵셔널 바인딩 활용
    func fullAddress() -> String? {
        var restAddress: String? = nil
        
        if let buildingInfo: Building = self.building {
            
            restAddress = buildingInfo.name
            
        } else if let detail = self.detailAddress {
            restAddress = detail
        }
        
        guard let rest: String = restAddress else {
            return nil
        }
        
        var fullAddress: String = self.province
        fullAddress += " " + self.city
        fullAddress += " " + self.street
        fullAddress += " " + rest
        
        return fullAddress
    }
    
    func printAddress() {
        if let address: String = self.fullAddress() {
            print(address)
        }
    }
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

// 옵셔널 체이닝을 통한 값 할당
yagom.address = Address(province: "충청북도", city: "청주시 청원구", street: "충청대로")
yagom.address?.building = Building(name: "곰굴")
yagom.address?.building?.room = Room(number: 0)
yagom.address?.building?.room?.number = 505


yagom.address?.fullAddress()?.isEmpty   // false
yagom.address?.printAddress()
