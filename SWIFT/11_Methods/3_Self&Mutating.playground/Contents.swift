class LevelClass {
    var level: Int = 0
    
    func jumpLevel(to level: Int) {
        print("Jump to \(level)")
        self.level = level
    }
    
    func reset() {
        // 오류! self 프로퍼티 참조 변경 불가!
        // self = LevelClass()
        level = 0
    }
}

struct LevelStruct {
    var level: Int = 0
    
    mutating func levelUp() {
        print("Level Up!")
        level += 1
    }
    
    mutating func reset() {
        print("Reset!")
        self = LevelStruct()
    }
}

var levelStructInstance: LevelStruct = LevelStruct()
levelStructInstance.levelUp()       // Level Up!
print(levelStructInstance.level)    // 1

levelStructInstance.reset()         // Reset!
print(levelStructInstance.level)    // 0


enum onOffSwitch {
    case on, off
    mutating func nextState() {
        self = self == .on ? .off : .on
    }
}

var toggle: onOffSwitch = onOffSwitch.off
toggle.nextState()
print(toggle)   // on
