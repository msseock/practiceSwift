// available 속성을 갖는 열거형의 항목 순회
enum School: String, CaseIterable {
    case primary = "유치원"
    case elementary = "초등학교"
    case middle = "중학교"
    case high = "고등학교"
    case college = "대학"
    case university = "대학교"
    @available(iOS, obsoleted: 12.0)
    case graduate = "대학원"
    
    static var allCases: [School] {
        let all: [School] = [.primary,
                             .elementary,
                             .middle,
                             .high,
                             .college,
                             .university]
        #if os(iOS)
        return all
        #else
        return all + [.graduate]
        #endif
    }
}

let allCases: [School] = School.allCases
print(allCases)
// 실행환경에 따라 다른 결과
