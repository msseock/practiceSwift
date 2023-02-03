// 클로저를 통한 student 프로퍼티 기본값 설정
struct Student {
    var name: String?
    var number: Int?
}

class SchoolClass {
    var students: [Student] = {
        // 새로운 인스턴스를 생성하고 사용자 정의 연산을 통한 후 반환
        // 반환되는 값의 타입은 [Student] 타입이어야 함
        var arr: [Student] = [Student]()
        
        for num in 1...15 {
            var student: Student = Student(name: nil, number: num)
            arr.append(student)
        }
        
        return arr
    }()
}

let myClass: SchoolClass = SchoolClass()
print(myClass.students.count)   // 15
