//
//  ChartHelper.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 20/6/21.
//

import SwiftUI

struct ChartHelper: View {
    var quote: [QuoteModel]?
    var historicalPrices: [HistoricalPricesModel]?
    
    var body: some View {
        CustomRectangleBox()
            .frame(height: 270)
            .padding(.horizontal)
            .overlay(
                VStack {
                    if let quote = quote?.first {
                        HStack(alignment: .center) {
                            Text("\(quote.latestPrice ?? 0, specifier: "%.2f")")
                                .foregroundColor(quote.changePercent ?? 0 < 0 ? .red: .green)
                                .fontWeight(.semibold)

                            Text("\(quote.changePercent ?? 0 * 100, specifier: "%.2f")%")
                                .foregroundColor(quote.changePercent ?? 0 < 0 ? .red: .green)
                                .font(.callout)
                                .fontWeight(.semibold)
                        }
                        .padding(.top)
                    }
                }
            )
    }
}

struct ChartHelper_Previews: PreviewProvider {
    static var previews: some View {
        ChartHelper(
            quote: [
                QuoteModel(companyName: "apple inc", latestPrice: 120.3, changePercent: 0.03)
            ],
            historicalPrices: [
                HistoricalPricesModel(close: 120.3, date: "2020-01-01", minute: nil)
            ]
        )
    }
}
