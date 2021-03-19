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
    @State private var orientation: UIDeviceOrientation = UIDevice.current.orientation
    @State var showingChartIndicator = false
    @State var pointInPath: CGPoint = .zero
    @State var indexValue = Int()
    
    
    var body: some View {
        let prices = historicalPrices.map { $0.close }
        let dates = historicalPrices.map { $0.date }
        let minutes = historicalPrices.map {$0.minute }
        
        VStack {
            ZStack {
                if showingChartIndicator {
                    PriceChartIndicator(prices: prices, dates: dates, minutes: minutes, indexValue: $indexValue)
                } else {
                    DateSelection(period: period, selectedperiod: $selectedPeriod)
                        .padding(.horizontal)
                        .onChange(of: selectedPeriod, perform: { (value) in
                            let url = rangeEndpointSelector(value)
                            request(url: url, model: [HistoricalPriceModel].self) { self.historicalPrices = $0 }
                        })
                }
            }
            .frame(height: 40)
            
            let (width, height) = lineViewSize()
            if !historicalPrices.isEmpty {
                LineView(colour: lineViewColour(prices) ,width: width, height: height, normalizedData: normalize(prices), showingChartIndicator: $showingChartIndicator, pointInPath: $pointInPath, indexValue: $indexValue)
                    .frame(width: width, height: height)
                    .rotationEffect(.degrees(180), anchor: .center)
                    .rotation3DEffect(.degrees(180), axis: (x: 0.0, y: 1.0, z: 0.0))
                    .padding([.top, .bottom])
                    // Detect changes on device orientation and upodate view
                    .onReceive(NotificationCenter.Publisher(center: .default, name: UIDevice.orientationDidChangeNotification)) { _ in
                              self.orientation = UIDevice.current.orientation
                            }
            }
        }
        .onAppear {
            let url = getUrl(endpoint: .historicalPrices, symbol: symbol, range: "3m")
            request(url: url, model: [HistoricalPriceModel].self) { self.historicalPrices = $0 }
        }
    }
    
    private enum HistoricalInterval {
        case oneWeek
        case oneMonth
    }
    
    private func selected(interval: HistoricalInterval) -> String {
        switch interval {
        case .oneWeek:
            return "5dm"
        case .oneMonth:
            return "1mm"
        }
    }
    
    private func rangeEndpointSelector(_ value: Int) -> String {
        var url = ""
        
        
        if selectedPeriod == 0 {  // 1 week
            url = getUrl(endpoint: .historicalPrices, symbol: symbol, range: selected(interval: .oneWeek))
        } else if selectedPeriod == 1 {  // 1 month
            url = getUrl(endpoint: .historicalPrices, symbol: symbol, range: selected(interval: .oneMonth))
        } else {  // The rest
            url = getUrl(endpoint: .historicalPrices, symbol: symbol, range: period[value])
        }
        
        return url
    }
    
    private func lineViewColour(_ prices: [Double]) -> Color {
        var colour = Color(.systemGreen)
        
        let firstPrice = prices[0]
        let lastPrice = prices.last
        
        if lastPrice! < firstPrice {
            colour = Color(.systemRed)
        }
        
        return colour
    }
    
    private func lineViewSize() -> (CGFloat, CGFloat) {
        var divisor: CGFloat = 3
        
        // if running on iPad
        if UIDevice.current.userInterfaceIdiom == .pad {
            divisor = 6
        }
        
        var width = deviceSize.width
        var height = deviceSize.width / divisor
        
        if orientation.isLandscape {
            width = deviceSize.height
            height = deviceSize.height / divisor
        }
        
        return (width, height)
    }
}

struct HistoricalPriceView_Previews: PreviewProvider {
    static var previews: some View {
        ChartView(symbol: "aapl")
    }
}
