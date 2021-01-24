//
//  Price.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 22/1/21.
//

import SwiftUI
import SwiftUICharts
/*
struct Stock: View {
    @ObservedObject var historicalPrices = HistoricalPrices()
    @ObservedObject var latestPrice = LatestPrice()
    
    var periods = ["1D", "1W", "1M", "3M", "6M", "1Y", "2Y", "5Y"]
    @State var selectedPeriod = 3
    var name: String
    var symbol: String
    
    var body: some View {
        VStack {
            Divider()
            
            let price = latestPrice.latestPrice
            let change = latestPrice.changePercent*100
            //let marketIsOpen = latestPrice.isUSMarketOpen
            
            if latestPrice.showingView {
                CurrentPrice(price: price, change: change, marketIsOpen: false)
            } else {
                HStack {
                ProgressView()
                    .padding(.leading)
                    Spacer()
                }
            }
            
            Divider()
            DateSelection(selectedperiod: $selectedPeriod)
                .padding([.leading, .trailing])
                .onChange(of: selectedPeriod, perform: { value in
                    historicalPrices.showingView.toggle()
                    historicalPrices.request(symbol: self.symbol, period: periods[selectedPeriod], sandbox: true)
                })
            
            if historicalPrices.showingView {
                let prices = historicalPrices.result.map { $0.close }
                LineView(data: scalateChart(prices: prices, selectedPeriod: selectedPeriod), title: "", style: chartStyle())
                    .padding([.leading, .trailing])
                    .offset(y: -40)
            } else {
                ProgressView()
            }
        }
        .onAppear {
            historicalPrices.request(symbol: self.symbol, period: periods[selectedPeriod], sandbox: true)
            latestPrice.request(symbol: self.symbol, sandbox: true)
        }
    }
}

struct Price_Previews: PreviewProvider {
    static var previews: some View {
        Stock(name: "Apple Inc", symbol: "AAPL")
    }
}
*/
