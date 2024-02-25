//
//  LayingOutContainerView.swift
//  BulletJournal
//
//  Created by 석민솔 on 2/5/24.
//

import SwiftUI

struct LayingOutContainerView: View {
    var body: some View {
        VStack {
            ZStack {
                Rectangle()
                    .foregroundColor(.blue)
                Circle()
                    .foregroundColor(.yellow)
            }
            
            ZStack {
                Rectangle()
                    .foregroundColor(.blue)
                HStack {
                    Circle()
                        .foregroundColor(.white)
                    Circle()
                        .foregroundColor(.black)
                }
            }
        }
    }
}

#Preview {
    LayingOutContainerView()
}
