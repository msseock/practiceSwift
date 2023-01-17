// 대괄호를 사용하여 배열임을 표현 (1)
var names: Array<String> = ["yagom", "chulsoo", "younghee", "yagom"]

// 위 선언과 정확이 동일한 표현. [String]은 Array<String>의 축약 표현
var names2: [String] = ["yagom", "chulsoo", "younghee", "yagom"]

var emptyArray: [Any] = [Any]()         // Any 데이터를 요소로 갖는 빈 배열을 생성
var emptyArray2: [Any] = Array<Any>()    // 위 선언과 정확히 같은 동작을 하는 코드

// 배열의 타입을 정확히 명시해줬다면 []만으로도 빈 배열을 생성할 수 있음
var emptyArray3: [Any] = []
print(emptyArray.isEmpty)   // true
print(names.count)          // 4

// MARK: 배열의 사용
print(names[2])         // younghee
names[2] = "jenny"      // (2)
print(names[2])         // jenny
//print(names[4])        // 인덱스의 범위를 벗어났기 때문에 오류 발생


//names[4] = "elsa"       // 인덱스의 범위를 벗어났기 때문에 올 발생
names.append("elsa")    // 마지막에 elsa가 추가됨 (3)
names.append(contentsOf: ["john", "max"])   // 맨 마지막에 john과 max가 추가됨 (4)
names.insert("happy", at: 2)                // 인덱스 2에 삽입됨 (5)
// 인덱스 5의 위치에 jinhee와 minsoo가 삽입됨 (6)
names.insert(contentsOf: ["jinhee", "minsoo"], at: 5)

print(names[4])                         // yagom
print(names.firstIndex(of: "yagom"))    // 0
print(names.firstIndex(of: "christal")) // nil
print(names.first)                      // yagom
print(names.last)                       // max


let firstItem: String = names.removeFirst()     // (7)
let lastItem: String = names.removeLast()       // (8)
let indexZeroItem: String = names.remove(at: 0) // (9)

print(firstItem)
print(lastItem)
print(indexZeroItem)
print(names[1 ... 3])
