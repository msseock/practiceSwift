// 스위프트 표준 연산자 우선순위 그룹
precedencegroup BitWiseShiftPrecedence {
    higherThan: MultiplicationPrecedence
}

precedencegroup FunctionArrowPrecedence {
    associativity: right
    higherThan: AssignmentPrecedence
}

precedencegroup MultiplicationPrecedence {
    associativity: left
    higherThan: AdditionPrecedence
}

precedencegroup TernaryPrecedence {
    associativity: right
    higherThan: FunctionArrowPrecedence
}

precedencegroup DefaultPrecedence {
    higherThan: TernaryPrecedence
}

precedencegroup LogicalDisjunctionPrecedence {
    associativity: left
    higherThan: TernaryPrecedence
}

precedencegroup LogicalConjunctionPrecedence {
    associativity: left
    higherThan: LogicalDisjunctionPrecedence
}

precedencegroup ComparisonPrecedence {
    higherThan: LogicalConjunctionPrecedence
}

precedencegroup NilCoalescingPrecedence {
    associativity: right
    higherThan: ComparisonPrecedence
}

precedencegroup AdditionPrecedence {
    associativity: left
    higherThan: RangeFormationPrecedence
}

precedencegroup CastingPrecedence {
    higherThan: NilCoalescingPrecedence
}

precedencegroup AssignmentPrecedence {
    associativity: right
    assignment: true
}

precedencegroup RangeFormationPrecedence {
    higherThan: CastingPrecedence
}

// 연산자 우선순위에 따른 처리순서
let intValue: Int = 1
let bitwiseShift:Int = intValue << 3
let resultValue1: Int = intValue << 3 + 5   // 8 + 5 => 13
let resultValue2: Int = 1 * 3 + 5   // 3 + 5 => 8
