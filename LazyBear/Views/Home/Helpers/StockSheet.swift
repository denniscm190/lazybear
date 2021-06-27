//
//  StockSheet.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 13/6/21.
//

import SwiftUI

struct StockSheet: View {
    var listName: String
    var companies: [CompanyModel]
    
    var body: some View {
        VStack {
            List(companies, id: \.self) { company in
                NavigationLink(destination:
                    CompanyView(symbol: company.symbol, name: company.companyName)
                        .navigationTitle(company.symbol.uppercased())
                ) {
                    StockSheetRow(company: company)
                }
            }
        }
    }
}

struct StockSheet_Previews: PreviewProvider {
    static var previews: some View {
        StockSheet(
            listName: "Most active",
            companies: [CompanyModel(symbol: "aapl", companyName: "Apple Inc", latestPrice: 120.3, changePercent: 0.03, intradayPrices: [120.3])]
        )
    }
}
