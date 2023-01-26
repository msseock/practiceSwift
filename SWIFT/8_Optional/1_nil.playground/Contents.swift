// 옵셔널 변수의 선언 및 nil 할당
var myName: String? = "msseock"
print(myName)   // Optional("msseock")

/*
 옵셔널 타입의 값을 print 함수를 통해 출력하면
 Optional("msseock")이라고 출력되는 것이 정상
 
 옵셔널 타입의 값을 print 함수의 매개변수로 전달하면
 컴파일러 경고가 발생할 수 있음.
*/

myName = nil

print(myName)   // nil
