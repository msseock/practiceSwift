func hello(name: String) -> String {
    return "Hello \(name)!"
}

let helloJenny: String = hello(name: "Jenny")
print(helloJenny)   // Hello Jenny!

func introduce(name: String) -> String {
    "제 이름은 " + name + "입니다."
    // [return "제 이름은 " + name + "입니다."]와 같은 동작
}

let introduceJenny: String = introduce(name: "Jenny")
print(introduceJenny)   // 제 이름은 Jenny입니다.
