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
    
    @State private var showingStatistics = false
    
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
                                        horizontalAlignment: .leading,
                                        verticalAlignment: .center,
                                        orientation: .HStack,
                                        priceFont: .title3,
                                        priceFontWeight: .semibold,
                                        percentFont: .body,
                                        percentFontWeight: .semibold,
                                        showBackground: true
                                    )
                                    PriceView(latestPrice: latestPrice, changePercent: changePercent, style: priceViewStyle)
                                }
                                Spacer()
                                
                                if let _ = company.chartData.keyStats {
                                    Button("See stats", action: { showingStatistics = true })
                                }
                            }
                            .padding([.top, .leading, .trailing])
                            
                            Spacer()
                            if let historicalPrices = company.chartData.historicalPrices {
                                let prices = historicalPrices.compactMap { $0.close }
                                let dates = historicalPrices.compactMap { $0.date }
//                                let hours = historicalPrices.compactMap { $0.minute }
                                LineChartView(data: prices, dates: dates, hours: nil, dragGesture: true)
                                    .padding(.bottom)
                            }
                        }
                    )
                
                if let latestNews = company.chartData.latestNews {
                    VStack(spacing: 20) {
                        ForEach(latestNews, id: \.self) { new in
                            NewsRow(new: new)
                        }
                    }
                    .padding(.top)
                }
            }
            .sheet(isPresented: $showingStatistics) {
                StatsView(keyStats: company.chartData.keyStats!)
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
    
    /*
     Price data is cached, so when the view disappears and appears again in a few seconds, the cached data is shown up. But the date range
     is incorrect because, always when this view appears, selectedRange is "3M".
     */
    private func checkDateRange() {
        
    }
}

struct Chart_Previews: PreviewProvider {
    static var previews: some View {
        Chart(company: Company(), symbol: "aapl")
    }
}
