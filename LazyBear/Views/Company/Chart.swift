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
    var ranges = ["1D", "5D", "1M", "3M", "6M", "1Y", "5Y"]  /// DatePicker ranges
    
    @State private var selectedRange = "3M"  /// Selected DatePicker range
    @State private var timer = Timer.publish(every: 10, on: .main, in: .common).autoconnect() /// Set recurrent price request
    @State private var showingStatistics = false  /// Show StatisticsView of the company
    
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
                        /*
                         Show PriceView and Chart
                         */
                        VStack {
                            HStack {
                                if let quote = company.chartData.quote![symbol.uppercased()] {
                                    if let latestPrice = quote.latestPrice, let changePercent = quote.changePercent {
                                        HStack(alignment: .center) {
                                            Text("\(latestPrice, specifier: "%.2f")")
                                                .foregroundColor(changePercent < 0 ? .red: .green)
                                                .fontWeight(.semibold)

                                            Text("\(changePercent * 100, specifier: "%.2f")%")
                                                .foregroundColor(changePercent < 0 ? .red: .green)
                                                .font(.callout)
                                                .fontWeight(.semibold)
                                        }
                                        .padding(.top)
                                    }
                                }
                                Spacer()
                                
                                if let _ = company.chartData.keyStats {  /// Check if keyStats is empty -> Hide button
                                    Button("See stats", action: { showingStatistics = true })
                                }
                            }
                            .padding([.top, .leading, .trailing])
                            
                            Spacer()
                            if let historicalPrices = company.chartData.historicalPrices {
                                let prices = historicalPrices.compactMap { $0.close }
                                let dates = historicalPrices.compactMap { $0.date }
                                LineChartView(data: prices, dates: dates, hours: nil, dragGesture: true)
                                    .padding(.bottom)
                            }
                        }
                    )
                
                /*
                 Show latest news
                 */
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
            .onDisappear { self.timer.upstream.connect().cancel() }  /// Stop timer
            .onReceive(timer) { _ in
                let url = "https://api.lazybear.app/company/chart/symbol=\(symbol)/type=streaming"
                company.request(url, .streaming, "chart") }  /// Receive timer notification
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
