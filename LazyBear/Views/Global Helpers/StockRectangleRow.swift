//
//  StockRectangleRow.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 28/3/21.
//

import SwiftUI


struct StockRectangleRow: View {
    var listType: String
    var list: [CompanyQuoteModel]
    var intradayPrices: [String: [IntradayPricesResult]]
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(adaptTitle(listType))
                .font(.title3)
                .fontWeight(.semibold)
                .padding([.top, .horizontal])
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 20) {
                    ForEach(list, id: \.self) { company in
                        StockItem(company: company, intradayPrices: self.intradayPrices[company.symbol]!)
                    }
                }
                .padding()
            }
            .frame(height: 250)
        }
        .padding(.bottom)
    }
}

private func adaptTitle(_ listType: String) -> String {
    if listType == "mostactive" {
        return "Most active"
    } else {
        return listType.capitalized
    }
}


//struct StockRectangleRow_Previews: PreviewProvider {
//    static var previews: some View {
//        StockRectangleRow(listType: "gainers", list: [CompanyQuoteModel(companyName: "apple inc", symbol: "aapl", latestPrice: 120.30, changePercent: 0.034)])
//    }
//}
