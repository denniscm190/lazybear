//
//  ScrollCharts.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 15/1/21.
//

import SwiftUI
import SwiftUICharts

struct StockCharts: View {
    @State var historicalPrices: HistoricalPrices
    @State var width: CGFloat
    
    var body: some View {
        let prices = historicalPrices.result.map { $0.close }  // Get an array of the variable "Close" in the struct
        ScrollView {
            // Stock price
            LineChartView(data: prices, title: "Stock price", legend: "Last 20 days",  form: CGSize(width: width, height: width/2), rateValue: nil)
                .padding()
            
            // Volume
            let volume = historicalPrices.result.map { $0.volume }
            BarChartView(data: ChartData(points: volume), title: "Volume", form: CGSize(width: width, height: width/1.5))
                    .padding()
        }
    }
}

struct ScrollCharts_Previews: PreviewProvider {
    static var previews: some View {
        StockCharts(historicalPrices: HistoricalPrices.init(), width: 100)
    }
}
