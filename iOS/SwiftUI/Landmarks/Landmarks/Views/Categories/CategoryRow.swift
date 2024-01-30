//
//  CategoryRow.swift: 카테고리별 row 틀 만들어주기
//  Landmarks
//
//  Created by 석민솔 on 1/18/24.
//

import SwiftUI

struct CategoryRow: View {
    var categoryName: String
    var items: [Landmark]
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(categoryName)
                .font(.headline)
                .padding(.leading, 15)
                .padding(.top, 5)
            
            ScrollView(.horizontal, showsIndicators: false) {
                // Put the category's items in an HStack
                HStack(alignment: .top, spacing: 0) {
                    ForEach(items) { landmark in
                        // wrap the existing CategoryItem with a NavigationLink
                        NavigationLink {
                            LandmarkDetail(landmark: landmark)
                        } label: {
                            // The CategoryItem item itself is the label for the button, and its desination is the landmark detail view for the landmark represented by the card.
                            CategoryItem(landmark: landmark)
                        }
                    }
                }
            }
            .frame(height: 185)
        }
        
    }
}

#Preview {
    let landmarks = ModelData().landmarks
    return CategoryRow(
        categoryName: landmarks[0].category.rawValue,
        items: Array(landmarks.prefix(4))
    )
}
