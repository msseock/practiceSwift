// MARK: examples in Apple Books
enum Beverage: CaseIterable {
    case coffee, tea, juice
}

let numberOfChoices = Beverage.allCases.count
print("\(numberOfChoices) beverages available")
// 3 beverages available

for beverage in Beverage.allCases {
    print(beverage)
}
// coffee
// tea
// juice

// MARK: examples in 야곰 swift

// CaseIterable 프로토콜을 활용한 열거형의 순회
enum School: CaseIterable {
    case primary
    case elementary
    case middle
    case high
    case college
    case university
    case graduate
}

let allCases: [School] = School.allCases
print(allCases)
// [School.primary, School.elementary, School.middle, School.high,  School.college, School.university,  School.graduate]

// 원시값을 갖는 열거형의 항목 순회
enum Education: String, CaseIterable {
    case primary = "유치원"
    case elementary = "초등학교"
    case middle = "중학교"
    case high = "고등학교"
    case college = "대학"
    case university = "대학교"
    case graduate = "대학원"
}
let allCases2 = Education.allCases
print(allCases2)
// [School.primary, School.elementary, School.middle, School.high,  School.college, School.university,  School.graduate]
