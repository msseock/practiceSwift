//
//  SymbolDetail.swift
//  SymbolGrid
//
//  Created by 석민솔 on 2/4/24.
//

import SwiftUI

struct SymbolDetail: View {
    var symbol: Symbol

    var body: some View {
        VStack {
            Text(symbol.name)
                .font(.system(.largeTitle, design: .rounded))
            
            Image(systemName: symbol.name)
                .resizable()
                .scaledToFit()
                .symbolRenderingMode(.hierarchical)
                .foregroundColor(.accentColor)
        }
    }
}

struct Details_Previews: PreviewProvider {
    static var previews: some View {
        SymbolDetail(symbol: Symbol(name: "magnifyingglass"))
    }
}

