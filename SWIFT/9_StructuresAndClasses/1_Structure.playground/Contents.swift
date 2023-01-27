// BasicInformation 구조체 정의
struct BasicInformation {
    var name: String
    var age: Int
}

// BasicInformation 구조체의 인스턴스 생성 및 사용
// 프로퍼티 이름(name, age)으로 자동 생성된 이니셜라이저를 사용하여 구조체를 생성
var msseockInfo: BasicInformation = BasicInformation(name: "msseock", age: 99)
msseockInfo.age = 100       // 변경 가능
msseockInfo.name = "Seba"   // 변경 가능

let sebaInfo: BasicInformation = BasicInformation(name: "Seba", age: 99)
//sebaInfo.age = 100  // 변경 불가! 오류!

