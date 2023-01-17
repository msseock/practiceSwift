// MARK: Set의 선언과 생성
//var names: Set<String> = Set<String>()  // 빈 세트 생성
//var names: Set<String> = []             // 빈 세트 생성

// Array와 마찬가지로 대괄호 사용
var names: Set<String> = ["yagom", "chulsoo", "younghee", "yagom"]

// 그렇기 때문에 타입 추론을 사용하게 되면 컴파일러는 Set이 아닌 Array로 타입을 지정
var numbers = [100, 200, 300]
print(type(of: numbers))    // Array<Int>

print(names.isEmpty)    // false
print(names.count)      // 3 - 중복된 값은 허용되지 않아 yagom은 1개만 남음

// MARK: Set 사용
print(names.count)      // 3
names.insert("jenny")
print(names.count)      // 4

print(names.remove("chulsoo"))  // chulsoo
print(names.remove("john"))     // nil

// MARK: Set 활용 - 집합연산
let englishClassStudents: Set<String> = ["john", "chulsoo", "yagom"]
let koreanClassStudents: Set<String> = ["jenny", "yagom", "chulsoo", "hana", "minsu"]

// 교집합 {"yagom", "chulsoo"}
let intersectSet: Set<String> = englishClassStudents.intersection(koreanClassStudents)

// 여집합의 합(배타적 논리합) {"john", "jenny", "hana", "minsoo"}
let symmetricDiffSet: Set<String> = englishClassStudents.symmetricDifference(koreanClassStudents)

// 합집합 {"minsoo", "jenny", "yagom", "chulsoo", "hana"}
let unionSet: Set<String> = englishClassStudents.union(koreanClassStudents)

// 차집합 {john}
let subtractSet: Set<String> = englishClassStudents.subtracting(koreanClassStudents)

print(unionSet.sorted())


// MARK: Set 활용 - 포함관계 연산
let bird: Set<String> = ["비둘기", "닭", "기러기"]
let mammal: Set<String> = ["사자", "호랑이", "곰"]
let animal: Set<String> = bird.union(mammal)    // 새와 포유류의 합집합

print(bird.isDisjoint(with: mammal))        // 서로 배타적인지 - ture
print(bird.isSubset(of: animal))            // 새가 동물의 부분집합인지 - true
print(animal.isSuperset(of: mammal))        // 동물이 포유류의 전체집합인지 - true
print(animal.isSuperset(of: bird))          // 동물은 새의 전체집합인지 - true
