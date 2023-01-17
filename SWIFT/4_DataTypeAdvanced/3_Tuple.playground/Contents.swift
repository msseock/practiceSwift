// MARK: Tuple 기본

// String, Int, Double 타입을 갖는 튜플
var person: (String, Int, Double) = ("sol", 100, 192.5)

// 인덱스를 통해서 값을 빼 올 수 있음
print("이름: \(person.0), 나이: \(person.1), 신장: \(person.2)")

person.1 = 99       // 인덱스를 통해 값 할당 가능
person.2 = 178.5

print("이름: \(person.0), 나이: \(person.1), 신장: \(person.2)")

// MARK: Tuple 요소 이름 지정

// String, Int, Double 타입을 갖는 튜플
var secondPerson: (name: String, age: Int, height: Double) = ("yagom", 100, 200)

// 요소 이름을 통해서 값을 빼 올 수 있음
print("이름:\(secondPerson.name), 나이: \(secondPerson.age), 신장: \(secondPerson.height)")

secondPerson.age = 99   // 요소 이름을 통해 값을 할당
secondPerson.2 = 189.5  // 인덱스 통해서 값을 할당

// 기존처럼 인덱스를 이용해 값을 빼 올 수도 있음
print("이름: \(secondPerson.0), 나이: \(secondPerson.1), 신장: \(secondPerson.2)")


// MARK: Tuple 별칭 지정
typealias PersonTuple = (name: String, age: Int, height: Double)

let sol: PersonTuple = ("sol", 100, 189.5)
let eric: PersonTuple = ("eric", 150, 194.5)

print("이름: \(sol.name), 나이: \(sol.age), 신장: \(sol.height)")
print("이름: \(eric.name), 나이: \(eric.age), 신장: \(eric.height)")
