// Closed Range Operator
for index in 1...5 {
    print("\(index) time 5 is \(index * 5)")
}
//1 time 5 is 5
//2 time 5 is 10
//3 time 5 is 15
//4 time 5 is 20
//5 time 5 is 25

// Half-Open Range Operator
let names = ["Anna", "Alex", "Brian", "Jack"]
let count = names.count
for i in 0..<count {
    print("Person \(i + 1) is called \(names[i])")
}
//Person 1 is called Anna
//Person 2 is called Alex
//Person 3 is called Brian
//Person 4 is called Jack

// One-Sided Ranges
for name in names[2...] {
    print(name)
}
// Brian
// Jack

for name in names[...2] {
    print(name)
}
// Anna
// Alex
// Brian

for name in names[..<2] {
    print(name)
}
// Anna
// Alex

let range = ...5
range.contains(7)   // false
range.contains(4)   // true
range.contains(-1)  // true
