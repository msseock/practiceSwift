//
//  AmazingAlignment.swift
//  BulletJournal
//
//  Created by 석민솔 on 2/5/24.
//

import SwiftUI

struct AmazingAlignment: View {
    var body: some View {
        VStack(alignment: .leading) {
            // 첫째줄
            Image(systemName: "books.vertical.fill")
                .font(.system(size: 40))
            Rectangle()
                .frame(maxWidth: .infinity, maxHeight: 10)
            
            // 둘째줄
            VStack(alignment: .trailing) {
                Image(systemName: "books.vertical.fill")
                    .font(.system(size: 40))
                Rectangle()
                    .frame(maxWidth: .infinity, maxHeight: 10)
            }
            
            // 셋째줄
            Image(systemName: "books.vertical.fill")
                .font(.system(size: 40))
                .frame(maxWidth: .infinity, alignment: .trailing)
            Rectangle()
                .frame(maxWidth: .infinity, maxHeight: 10)
            
            // 넷째줄
            HStack {
                Spacer()
                Image(systemName: "books.vertical.fill")
                    .font(.system(size: 40))
                    .background(Color.yellow)
                Image(systemName: "books.vertical.fill")
                    .font(.system(size: 40))
            }
            .background(Color.mint)
            Rectangle()
                .frame(maxWidth: .infinity, maxHeight: 10)
        }
        .padding(.horizontal)
        // 특정 너비 원하면
        .frame(width: 250)
        .border(Color.black, width: 10)
    }
}

#Preview {
    AmazingAlignment()
}
