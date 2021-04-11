//
//  StockRectangleRow.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 28/3/21.
//

import SwiftUI


struct StockRectangleRow: View {
    var listName: String
    var list: [QuoteModel]
    var nestedIntradayPrices: [String: NestedIntradayPricesModel]?
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(adaptTitle(listName))
                .font(.title3)
                .fontWeight(.semibold)
                .padding([.top, .horizontal])
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 20) {
                    ForEach(list, id: \.self) { company in
                        if let intradayPrices = nestedIntradayPrices?[company.symbol.uppercased()] {
                            StockItem(company: company, intradayPrices: intradayPrices.nestedIntradayPrices)
                        } else {
                            StockItem(company: company, intradayPrices: nil)
                        }
                    }
                }
                .padding()
            }
            .frame(height: 250)
        }
        .padding(.bottom)
    }
    
    private func testPrint(_ test: Any) -> Text {
        print(test)
        
        return Text("")
    }
}

private func adaptTitle(_ listType: String) -> String {
    if listType == "mostactive" {
        return "Most active"
    } else {
        return listType.capitalized
    }
}


struct StockRectangleRow_Previews: PreviewProvider {
    static var previews: some View {
        StockRectangleRow(
            listName: "mostactive",
            list: [QuoteModel(companyName: "apple inc", symbol: "aapl", latestPrice: 130.3, changePercent: 0.03)],
            nestedIntradayPrices: ["AAPL": NestedIntradayPricesModel(nestedIntradayPrices: [IntradayPricesModel(marketOpen: 130.3)])]
        )
    }
}
