// mutating 키워드의 사용
struct LevelStruct {
    var level: Int = 0 {
        didSet {
            print("Level \(level)")
        }
    }
    
    mutating func levelUp() {
        print("Level Up!")
        level += 1
    }
    
    mutating func levelDown() {
        print("Level Down")
        level -= 1
        if level < 0 {
            reset()
        }
    }
    
    mutating func jumpLevel(to: Int) {
        print("Jump to \(to)")
        level = to
    }
    
    mutating func reset() {
        print("Reset!")
        level = 0
    }
}

var levelStructInstance: LevelStruct = LevelStruct()
levelStructInstance.levelUp()          // Level Up!
// Level 1
levelStructInstance.levelDown()        // Level Down
// Level 0
levelStructInstance.levelDown()        // Level Down
// Level -1
// Reset!
// Level 0
levelStructInstance.jumpLevel(to: 3)    // Jump to 3
// Level 3
