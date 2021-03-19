//
//  CompanyRow.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 19/2/21.
//

import SwiftUI

struct CompanyRow: View {
    var symbol: String
    var name: String
    var rowNumber: Int
    var showPrice: Bool
    
    var body: some View {
        HStack {
            SideColor(rowNumber: rowNumber)
            VStack(alignment: .leading) {
                Text(symbol.uppercased())
                    .fontWeight(.semibold)

                Text(name.capitalized)
                    .lineLimit(1)
            }
            
            Spacer()
            if showPrice {
                PriceView(symbol: symbol, showVertical: true)
            }
        }
    }
}

struct Row_Previews: PreviewProvider {
    static var previews: some View {
        List {
            CompanyRow(symbol: "aapl", name: "apple inc", rowNumber: 2, showPrice: true)
        }
    }
}
