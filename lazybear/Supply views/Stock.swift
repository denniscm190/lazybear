//
//  Price.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 22/1/21.
//

import SwiftUI
import SwiftUICharts

struct Stock: View {
    @ObservedObject var historicalPrices = HistoricalPrices()
    var periods = ["1D", "1W", "1M", "3M", "6M", "1Y", "2Y", "5Y"]
    @State var selectedPeriod = 3
    var name: String
    var symbol: String
    
    var body: some View {
        VStack {
            Divider()
            CurrentPrice()
            Divider()
            DateSelection(selectedperiod: $selectedPeriod)
                .onChange(of: selectedPeriod, perform: { value in
                    historicalPrices.showingView.toggle()
                    historicalPrices.request(symbol: self.symbol, period: periods[selectedPeriod], sandbox: true)
                })
                .padding([.leading, .trailing])
            
            if historicalPrices.showingView {
                let prices = historicalPrices.result.map { $0.close }
                LineView(data: scalate(prices: prices), title: "", style: chartStyle())
                    .padding([.leading, .trailing])
                    .offset(y: -40)
            }
            else {
                ProgressView()
            }
        }
        .onAppear {
            historicalPrices.request(symbol: self.symbol, period: periods[selectedPeriod], sandbox: true)
        }
    }
    
    func chartStyle() -> ChartStyle {
        let gradient = GradientColor(start: .green, end: .green)
        let style = ChartStyle(
            backgroundColor: .white,
            accentColor: .green,
            gradientColor: gradient,
            textColor: .black,
            legendTextColor: .black,
            dropShadowColor: .white)
        
        return style
    }
    
    func scalate(prices: [Double]) -> [Double] {
        // Remove every two items to shorter the chart data points
        var indexesToRemove = Set<Int>()

        if selectedPeriod >= 5 {
            for index in 0..<prices.count {
                indexesToRemove.insert(index*2)
            }
        }
        let prices = prices
            .enumerated()
            .filter { !indexesToRemove.contains($0.offset) }
            .map { $0.element }
        
        return prices
    }
}

struct Price_Previews: PreviewProvider {
    static var previews: some View {
        Stock(name: "Apple Inc", symbol: "AAPL")
    }
}
