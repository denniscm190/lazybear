//
//  HistoricalPriceView.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 21/2/21.
//

import SwiftUI

struct ChartView: View {
    var symbol: String
    @State private var historicalPrices = [HistoricalPriceModel]()
    @EnvironmentObject var deviceSize: DeviceSize
   
    // Date picker
    var period = ["1W", "1M", "3M", "6M", "1Y", "2Y", "5Y"]
    @State var selectedPeriod = 2
    
    // Line View
    @State var showingChartIndicator = false
    @State var pointInPath: CGPoint = .zero
    @State var indexValue = Int()
    
    var body: some View {
        
        VStack {
            let prices = historicalPrices.map { $0.close }
            let dates = historicalPrices.map { $0.date }
            ZStack {
                if showingChartIndicator {
                    PriceChartIndicator(prices: prices, dates: dates, indexValue: $indexValue)
                } else {
                    DateSelection(period: period, selectedperiod: $selectedPeriod)
                        .padding(.horizontal)
                        .onChange(of: selectedPeriod, perform: { (value) in
                            let url = getUrl(endpoint: .historicalPrices, symbol: symbol, range: period[value])
                            request(url: url, model: [HistoricalPriceModel].self) { self.historicalPrices = $0 }
                        })
                }
            }
            .frame(height: 40)
            
            if !historicalPrices.isEmpty {
                LineView(width: deviceSize.width, height: deviceSize.width/3, normalizedData: normalize(prices), showingChartIndicator: $showingChartIndicator, pointInPath: $pointInPath, indexValue: $indexValue)
                    .frame(width: deviceSize.width, height: deviceSize.width / 3)
                    .rotationEffect(.degrees(180), anchor: .center)
                    .rotation3DEffect(.degrees(180), axis: (x: 0.0, y: 1.0, z: 0.0))
                    .padding([.top, .bottom])
            }
        }
        .onAppear {
            let url = getUrl(endpoint: .historicalPrices, symbol: symbol, range: "3m")
            request(url: url, model: [HistoricalPriceModel].self) { self.historicalPrices = $0 }
        }

    }
}

struct HistoricalPriceView_Previews: PreviewProvider {
    static var previews: some View {
        ChartView(symbol: "aapl")
    }
}
