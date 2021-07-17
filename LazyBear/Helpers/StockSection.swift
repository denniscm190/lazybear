//
//  StockSection.swift
//  lazybear
//
//  Created by Dennis Concepción Martín on 17/07/2021.
//

import SwiftUI

struct StockSection: View {
    var companyQuote: CompanyQuoteModel
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Stock")
                .font(.title2)
                .fontWeight(.semibold)
            
            Text("\(companyQuote.companyName ?? "Company") is currently trading at \(companyQuote.latestPrice ?? 0, specifier: "%.2f"). That's a price change of \((companyQuote.change ?? 0.0), specifier: "%.2f") or a \((companyQuote.changePercent ?? 0)*100, specifier: "%.2f")% \(generateTendency()) since yesterday.")
        }
    }
    
    private func generateTendency() -> String {
        if companyQuote.change ?? 0 >= 0 {
            return "up"
        } else {
            return "down"
        }
    }
}

struct StockSection_Previews: PreviewProvider {
    static var previews: some View {
        StockSection(companyQuote: CompanyQuoteModel(symbol: "AAPL", companyName: "Apple Inc", latestPrice: 120.30, changePercent: 0.03, change: 1.50))
    }
}
