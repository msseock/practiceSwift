// 튜플의 접근수준 부여
internal class InternalClass {}
private struct PrivateStruct {}

// 요소로 사용되는 InternalClass와 PrivateStruct의 접근수준이 publicTuple보다 낮기 때문에 사용할 수 없음
//public var publicTuple: (first: InternalClass, second: PrivateStruct) = (InternalClass(), PrivateStruct())

// 요소로 사용되는 InternalClass와 PrivateStruct의 접근수준이 privateTuple과 같거나 높기 때문에 사용할 수 있음
private var privateTuple: (first: InternalClass, second: PrivateStruct) = (InternalClass(), PrivateStruct())
