//
//  Chart.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 8/5/21.
//

import SwiftUI
import StockCharts

struct Chart: View {
    @ObservedObject var company: Company
    var symbol: String
    
    // Date picker
    var ranges = ["1D", "5D", "1M", "3M", "6M", "1Y", "5Y"]
    @State private var selectedRange = "3M"
    
    // Set recurrent price request
    @State private var timer = Timer.publish(every: 10, on: .main, in: .common).autoconnect()
    
    var body: some View {
        if company.showChartView {
            VStack {
                DatePicker(ranges: ranges, selectedRange: $selectedRange)
                    .onChange(of: selectedRange, perform: { range in
                        let url = "https://api.lazybear.app/company/chart/symbol=\(symbol)/type=refresh/range=\(range.lowercased())"
                        company.request(url, .refresh, "chart")
                    })
                
                RoundedRectangle(cornerRadius: 15)
                    .foregroundColor(Color(.secondarySystemBackground))
                    .frame(height: 270)
                    .overlay(
                        VStack {
                            HStack {
                                if let quote = company.chartData.quote![symbol.uppercased()] {
                                    let latestPrice = quote.latestPrice ?? 0
                                    let changePercent = quote.changePercent ?? 0
                                    let priceViewStyle = PriceViewStyle(
                                        alignment: .leading,
                                        priceFont: .headline,
                                        priceFontWeight: .semibold,
                                        percentFont: .body,
                                        percentFontWeight: .medium
                                    )
                                    PriceView(latestPrice: latestPrice, changePercent: changePercent, style: priceViewStyle)
                                }
                                Spacer()
                            }
                            .padding([.top, .leading, .trailing])
                            
                            if let historicalPrices = company.chartData.historicalPrices {
                                if let prices = historicalPrices.compactMap { $0.close } {  // Map without nil
                                    LineChartView(data: prices, dates: nil, hours: nil, dragGesture: true)
                                        .padding(.bottom)
                                }
                            }
                        }
                    )
                
                if let latestNews = company.chartData.latestNews {
                    ForEach(latestNews, id: \.self) { new in
                        NewsRow(new: new)
                    }
                }
            }
            .onAppear { self.timer = Timer.publish(every: 10, on: .main, in: .common).autoconnect() }  // Start timer
            .onDisappear { self.timer.upstream.connect().cancel() }  // Stop timer
            .onReceive(timer) { _ in
                let url = "https://api.lazybear.app/company/chart/symbol=\(symbol)/type=streaming"
                company.request(url, .streaming, "chart") }  // Receive timer notification
        } else {
            ProgressView()
                .onAppear {
                    let url = "https://api.lazybear.app/company/chart/symbol=\(symbol)/type=init"
                    company.request(url, .initial, "chart")
                }
        }
    }
}

struct Chart_Previews: PreviewProvider {
    static var previews: some View {
        Chart(company: Company(), symbol: "aapl")
    }
}
