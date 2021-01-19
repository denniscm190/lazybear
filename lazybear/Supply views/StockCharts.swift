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
    @State var geoWidth: CGFloat
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
                LineChartView(data: prices, title: "Stock price", legend: "Last month",  form: CGSize(width: normalSize.0, height: normalSize.1), rateValue: nil)
                    .padding()
                
                let maxPrice = String(prices.max()!)
                let minPrice = String(prices.min()!)
                StockStats(dataMax: maxPrice, dataMin: minPrice, width: normalSize.0, height: normalSize.1, title: "price")
                
                let volume = historicalPrices.result.map { $0.volume }
                BarChartView(data: ChartData(points: volume), title: "Volume", form: CGSize(width: specialSize.0, height: specialSize.1))
                        .padding()
                
                let maxVolume = String(volume.max()!)
                let minVolume = String(volume.min()!)
                StockStats(dataMax: maxVolume, dataMin: minVolume, width: normalSize.0, height: normalSize.1, title: "volume")
                
                let change = historicalPrices.result.map { $0.changePercent*100 }
                LineChartView(data: change, title: "Daily percentage change", legend: "Last month",  form: CGSize(width: normalSize.0, height: normalSize.1), rateValue: nil)
                    .padding()
                
                let maxChange = String(change.max()!)
                let minChange = String(change.min()!)
                StockStats(dataMax: maxChange, dataMin: minChange, width: normalSize.0, height: normalSize.1, title: "daily percentage change")
                
            }
        }
    }
    
    func chartSize(chartType: String) -> (CGFloat, CGFloat) {
        var height = CGFloat()
        var width = CGFloat()
        
        if horizontalSizeClass == .compact && verticalSizeClass == .regular {
            //print("Running on iPhone")
            
            if chartType == "special" {
                //size = CGSize(width: width, height: width/1.5)
                width = geoWidth
                height = geoWidth/1.5
            }
            else {
                //size = CGSize(width: width, height: width/2)
                width = geoWidth
                height = geoWidth/2
            }
        }
        else {
            //print("Running on iPad")
            //size = CGSize(width: 360, height: 240)
            width = CGFloat(360)
            height = CGFloat(240)
        }
        // Return tupple
        return  (width, height)
    }
}

struct ScrollCharts_Previews: PreviewProvider {
    static var previews: some View {
        StockCharts(historicalPrices: HistoricalPrices.init(), geoWidth: 100)
    }
}
