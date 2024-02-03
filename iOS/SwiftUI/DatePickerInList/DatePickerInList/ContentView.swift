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
    
    var body: some View {
        NavigationView {
            List {
                DatePicker("날짜 선택", selection: $selectedDate, displayedComponents: .date)
                    .accentColor(isDatePickerVisible ? .blue : .primary)
                    .onTapGesture {
                        isDatePickerVisible.toggle()
                    }
                
                if isDatePickerVisible {
                    DatePicker("", selection: Binding(
                        get: { self.selectedDate },
                        set: { self.selectedDate = $0 }
                    ), displayedComponents: .date)
                    .datePickerStyle(.graphical)
                }
            }
            .navigationTitle("날짜 선택기")
            .animation(.smooth)


            
        }
    }
}

#Preview {
    ContentView()
}
