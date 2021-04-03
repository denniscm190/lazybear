//
//  TopStockItem.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 28/3/21.
//

import SwiftUI

struct TopStockItem: View {
    var company: CompanyQuoteModel
    @State private var intradayPrices = [IntradayPricesModel]()
    
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
                         
                        let prices = intradayPrices.compactMap { $0.open }
                        if prices.isEmpty {
                            Text("No data available")
                                .font(.caption)
                                .opacity(0.6)
                        } else {
                            LineView(data: prices)
                                .foregroundColor(company.changePercent < 0 ? .red: .green)
                                .padding(.vertical)
                                .clipped()
                        }
                            
                    }
                    ,alignment: .leading
                )
                .onAppear { requestIntradayPrices(company.symbol) }
    }
    
    private func requestIntradayPrices(_ symbol: String) {
        let url = "\(baseUrl)/stock/\(symbol)/intraday-prices?token=\(apiKey)"
        genericRequest(url: url, model: [IntradayPricesModel].self) {
            self.intradayPrices = $0
        }
    }
}

struct TopStockItem_Previews: PreviewProvider {
    static var previews: some View {
        TopStockItem(company: CompanyQuoteModel(companyName: "Akumin Inc", symbol: "AKU", latestPrice: 120.30, changePercent: 0.03))

    }
}
