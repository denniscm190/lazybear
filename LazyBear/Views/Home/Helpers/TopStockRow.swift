//
//  TopStockRow.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 28/3/21.
//

import SwiftUI

struct TopStockRow: View {
    var key: String
    var list: [CompanyRowModel]
    var intradayPricesDict: [String: IntradayPricesArray]
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(adaptTitle())
                .font(.title3)
                .fontWeight(.semibold)
                .padding([.top, .horizontal])
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 20) {
                    ForEach(list, id: \.self) { company in
                        let symbol = company.symbol.uppercased()
                        if let prices = intradayPricesDict[symbol] {
                            TopStockItem(company: company, intradayPricesArray: prices)
                        }
                        
                    }
                }
                .padding()
            }
            .frame(height: 250)
        }
        .padding(.bottom)
    }
    
    private func adaptTitle() -> String {
        if key == "mostactive" {
            
            return "Most active"
        } else {
            return key.capitalized
        }
    }
}


struct TopStockRow_Previews: PreviewProvider {
    static var previews: some View {
        let list = [CompanyRowModel(symbol: "aapl", companyName: "apple inc", latestPrice: 120.30, changePercent: 0.03)]
        let intradayPricesArray = IntradayPricesArray(intradayPrices: [IntradayPricesModel(open: 120.00)])
        TopStockRow(key: "Gainers", list: list, intradayPricesDict: ["AAPL": intradayPricesArray])
    }
}
