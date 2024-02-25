//
//  SizingView.swift
//  BulletJournal
//
//  Created by 석민솔 on 2/5/24.
//

import SwiftUI

struct SizingView: View {
    var body: some View {
        VStack {
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .foregroundStyle(.brown)
                    .frame(maxWidth: 200, maxHeight: 150)
                
                VStack {
                    Text("Roses are red,")
                    Image(systemName: "camera.macro")
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: 50)
                        .foregroundStyle(Color(.red).opacity(0.7))
                    Text("violets are blue,")
                }
            }
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .foregroundStyle(.brown)
                    .frame(maxWidth: 200, maxHeight: 150)

                VStack {
                    Text("I just love")
                    Image(systemName: "heart.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: 50)
                        .foregroundStyle(Color(.red).opacity(0.7))

                    Text("coding with you!")
                }
            }
        }
        .font(.headline)
        .foregroundColor(.white)
    }
}

#Preview {
    SizingView()
}
