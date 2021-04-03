//
//  TopStockRow.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 28/3/21.
//

import SwiftUI

struct TopStockRow: View {
    var listType: String
    var list: [CompanyQuoteModel]
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(adaptTitle())
                .font(.title3)
                .fontWeight(.semibold)
                .padding([.top, .horizontal])
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 20) {
                    ForEach(list, id: \.self) { company in
                        TopStockItem(company: company)
                    }
                }
                .padding()
            }
            .frame(height: 250)
        }
        .padding(.bottom)
    }
    
    private func adaptTitle() -> String {
        if listType == "mostactive" {
            
            return "Most active"
        } else {
            return listType.capitalized
        }
    }
}


struct TopStockRow_Previews: PreviewProvider {
    static var previews: some View {
        TopStockRow(listType: "gainers", list: [CompanyQuoteModel(companyName: "apple inc", symbol: "aapl", latestPrice: 120.30, changePercent: 0.03)])
    }
}
