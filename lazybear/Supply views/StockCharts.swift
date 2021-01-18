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
    @Environment(\.verticalSizeClass) var verticalSizeClass: UserInterfaceSizeClass?
    @Environment(\.horizontalSizeClass) var horizontalSizeClass: UserInterfaceSizeClass?
    
    var body: some View {
        ScrollView {
            let columns = lazyColumns(verticalSizeClass: verticalSizeClass!, horizontalSizeClass: horizontalSizeClass!,
                                      iphoneColumns: 1, ipadColumns: 2)
            
            LazyVGrid(columns: columns, spacing: 20) {
                let normalSize = chartSize(chartType: "")
                let specialSize = chartSize(chartType: "special")
                
                let prices = historicalPrices.result.map { $0.close }  // Get an array of the variable "Close" in the struct
                LineChartView(data: prices, title: "Stock price", legend: "Last month",  form: normalSize, rateValue: nil)
                    .padding()
                
                let maxPrice = String(prices.max()!)
                StockStats(data: maxPrice)
                
                let volume = historicalPrices.result.map { $0.volume }
                BarChartView(data: ChartData(points: volume), title: "Volume", form: specialSize)
                        .padding()
                
                let maxVolume = String(volume.max()!)
                StockStats(data: maxVolume)
                
                let change = historicalPrices.result.map { $0.changePercent*100 }
                LineChartView(data: change, title: "Daily percentage change", legend: "Last month",  form: normalSize, rateValue: nil)
                    .padding()
                
            }
        }
    }
    
    func chartSize(chartType: String) -> CGSize {
        var size = CGSize()
        if horizontalSizeClass == .compact && verticalSizeClass == .regular {
            print("Running on iPhone")
            
            if chartType == "special" {
                size = CGSize(width: width, height: width/1.5)
            }
            else {
                size = CGSize(width: width, height: width/2)
            }
        }
        else {
            print("Running on iPad")
            size = CGSize(width: 360, height: 240)
        }
        
        return size
    }
}

struct ScrollCharts_Previews: PreviewProvider {
    static var previews: some View {
        StockCharts(historicalPrices: HistoricalPrices.init(), width: 100)
    }
}
