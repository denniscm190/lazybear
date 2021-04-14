//
//  StockItem.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 28/3/21.
//

import SwiftUI

struct StockItem: View {
    var company: QuoteModel
    var intradayPrices: [IntradayPricesModel]?
    
    private let baseUrl = Bundle.main.infoDictionary?["IEX_URL"] as? String ?? "Empty url"
    private let apiKey = Bundle.main.infoDictionary?["IEX_API"] as? String ?? "Empty key"
    
    var body: some View {
        RoundedRectangle(cornerRadius: 20)
            .foregroundColor(Color(.secondarySystemBackground))
            .aspectRatio(0.8, contentMode: .fit)
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .overlay(
                VStack(alignment: .leading) {
                    Group {
                        Text(company.symbol.uppercased())
                            .fontWeight(.semibold)
                            .padding(.top)
                        
                        Text(company.companyName.capitalized)
                            .font(.callout)
                            .fontWeight(.semibold)
                            .opacity(0.6)
                            .lineLimit(1)
                        
                        PriceView(latestPrice: company.latestPrice, changePercent: company.changePercent)
                            
                    }
                    .padding(.horizontal)
                    
                    Spacer()
                     
                    if let prices = intradayPrices?.compactMap { $0.open } {
                        LineView(data: prices)
                            .foregroundColor(company.changePercent < 0 ? .red: .green)
                            .padding(.vertical)
                            .clipped()
                    }
                        
                }
                ,alignment: .leading
            )
    }
}

struct StockItem_Previews: PreviewProvider {
    static var previews: some View {
        StockItem(
            company: QuoteModel(companyName: "apple inc", symbol: "aapl", latestPrice: 130.3, changePercent: 0.03),
            intradayPrices: [IntradayPricesModel(open: 130.3)]
        )
    }
}
