//
//  ContentView.swift
//  DatePickerInList
//
//  Created by 석민솔 on 2/4/24.
//

import SwiftUI

struct ContentView: View {
    @State private var selectedDate = Date()
    @State private var isDatePickerVisible = false
    
    // 버튼에 들어갈 날짜 text 만들어주기
    var dateString: String {
        // DateFormatter 형식 지정
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy.MM.dd"
        
        // Date -> String
        let dateString = dateFormatter.string(from: selectedDate)
        
        return dateString
    }
    
    var body: some View {
        List {
            // 첫번째 row: 날짜 선택 button
            HStack {
                Text("날짜 선택")
                Spacer()
                Button {
                    isDatePickerVisible.toggle()
                } label: {
                    Text(dateString)
                }
                // 활성화될 때 accentColor로 변경
                .foregroundStyle(isDatePickerVisible ? Color.accentColor : Color.primary)
                // 기존 DatePicker 흉내내기(회색 박스 생김)
                .buttonStyle(.bordered)
            }

            
            // 두번째 row: 첫번째 row 날짜 부분 누르면 나오는 달력 모양 DatePicker
            if isDatePickerVisible {
                DatePicker("", selection: $selectedDate, displayedComponents: .date)
                // graphical style이 달력 모양
                .datePickerStyle(.graphical)
            }
        }
        // list 추가될 때 뚝뚝 끊기지 않도록 애니메이션 추가
        .animation(.smooth)
    }
}

#Preview {
    ContentView()
}
