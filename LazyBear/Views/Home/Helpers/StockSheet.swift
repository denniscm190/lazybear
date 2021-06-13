//
//  StockSheet.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 13/6/21.
//

import SwiftUI

struct StockSheet: View {
    var listName: String
    var companies: [String: QuoteModel]
    var intradayPrices: [String: [Double]]?
    
    @Environment(\.presentationMode) private var stockSheetPresentation
    
    var body: some View {
        NavigationView {
            VStack {
                List(Array(companies.keys.sorted()), id: \.self) { symbol in
                    NavigationLink(destination: CompanyView(symbol: symbol)) {
                        StockSheetRow(symbol: symbol, company: companies[symbol]!, intradayPrices: intradayPrices![symbol]!)
                    }
                }
            }
            .navigationTitle(listName)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {stockSheetPresentation.wrappedValue.dismiss()}) {
                        Image(systemName: "multiply")
                    }
                }
            }
        }
    }
}

struct StockSheet_Previews: PreviewProvider {
    static var previews: some View {
        StockSheet(listName: "Most active", companies: ["aapl": QuoteModel(changePercent: 0.03, companyName: "Apple Inc", latestPrice: 120.3)])
    }
}
