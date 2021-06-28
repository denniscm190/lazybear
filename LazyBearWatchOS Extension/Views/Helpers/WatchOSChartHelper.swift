//
//  WatchOSChartHelper.swift
//  LazyBearWatchOS Extension
//
//  Created by Dennis Concepción Martín on 27/06/2021.
//

import SwiftUI
import StockCharts

struct WatchOSChartHelper: View {
    @ObservedObject var company: Company
    
    var body: some View {
        VStack(alignment: .leading) {
            if let quote = company.data.quote?.first {
                if let latestPrice = quote.latestPrice, let changePercent = quote.changePercent {
                    Text("\(latestPrice, specifier: "%.2f")")
                        .font(.title)
                        .fontWeight(.semibold)
                        .foregroundColor(changePercent < 0 ? .red: .green)
                    
                    Text("\(changePercent * 100, specifier: "%.2f")%")
                        .fontWeight(.semibold)
                        .foregroundColor(changePercent < 0 ? .red: .green)
                }
                
                if let historicalPrices = company.data.historicalPrices {
                    let prices = historicalPrices.compactMap { $0.close }
                    LineChartView(data: prices, dates: nil, hours: nil, dragGesture: false)
                        .padding(.top)
                        .frame(height: 90)
                }
            }
        }
    }
}

struct StockView_Previews: PreviewProvider {
    static var previews: some View {
        WatchOSChartHelper(company: Company())
    }
}
