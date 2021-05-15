//
//  Chart.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 8/5/21.
//

import SwiftUI
import StockCharts

struct Chart: View {
    var chartData: ChartResponse
    var symbol: String
    
    // Date picker
    var ranges = ["1D", "5D", "1M", "3M", "6M", "1Y", "5Y"]
    @State private var selectedRange = "3M"
    
    
    var body: some View {
        let priceViewStyle = PriceViewStyle(
            alignment: .leading,
            priceFont: .headline,
            priceFontWeight: .semibold,
            percentFont: .body,
            percentFontWeight: .medium
        )
        
        VStack {
            DatePicker(ranges: ranges, selectedRange: $selectedRange)
            
            RoundedRectangle(cornerRadius: 15)
                .foregroundColor(Color(.secondarySystemBackground))
                .frame(height: 270)
                .overlay(
                    VStack {
                        HStack {
                            if let quote = chartData.quote![symbol.uppercased()] {
                                let latestPrice = quote.latestPrice ?? 0
                                let changePercent = quote.changePercent ?? 0
                                PriceView(latestPrice: latestPrice, changePercent: changePercent, style: priceViewStyle)
                            }
                            Spacer()
                        }
                        .padding([.top, .leading, .trailing])
                        
                        if let intradayPrices = chartData.intradayPrices![symbol.uppercased()] {
                            if let prices = intradayPrices.compactMap { $0.open } {
                                LineChartView(data: prices,
                                              dates: nil,
                                              hours: nil,
                                              dragGesture: true
                                )
                                    .padding(.bottom)
                            }
                        }
                    }
                )
            
            if let latestNews = chartData.latestNews {
                ForEach(latestNews, id: \.self) { new in
                    NewsRow(new: new)
                }
            }
        }
    }
}

struct Chart_Previews: PreviewProvider {
    static var previews: some View {
        Chart(
            chartData: ChartResponse(
                intradayPrices: ["AAPL": [IntradayPriceModel(open: 120.3)]],
                quote: ["aapl": QuoteModel(changePercent: 0.03, companyName: "Apple Inc", latestPrice: 120.3)],
                latestNews: [LatestNewsModel(
                                datetime: 1621037430000,
                                headline: "Chaos Monkeys' author calls Apple's statement on his departure defamatory",
                                image: "https://cloud.iexapis.com/v1/news/image/99abeb99-6d9e-47c8-ae7b-53404eacccec",
                                source: "Investing.com",
                                summary: "https://www.investing.com/news/stock-market-news",
                                url: "https://cloud.iexapis.com/v1/news/article/99abeb99-6d9e-47c8-ae7b-53404eacccec")]),
            
            symbol: "aapl"
        )
    }
}
