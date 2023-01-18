enum PastaTaste: CaseIterable {
    case cream, tomato
}

enum PizzaDough: CaseIterable {
    case cheeseCrust, thin, original
}

enum PizzaTopping: CaseIterable {
    case pepperoni, cheese, bacon
}

enum MainDish: CaseIterable {
    case pasta(taste: PastaTaste)
    case pizza(dough: PizzaDough, topping: PizzaTopping)
    case chicken(withSauce: Bool)
    case rice
    
    static var allCases: [MainDish] {
        return PastaTaste.allCases.map(MainDish.pasta) + PizzaDough.allCases.reduce([]) { (result, dough) -> [MainDish] in result + PizzaTopping.allCases.map {(topping) -> MainDish in MainDish.pizza(dough: dough, topping: topping)
            }
        }
        + [true, false].map(MainDish.chicken)
        + [MainDish.rice]
    }
}


print(MainDish.allCases.count)  // 14
print(MainDish.allCases)        // 모든 경우의 연관 값을 갖는 케이스 컬렉션
