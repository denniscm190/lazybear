//
//  HistoricalPriceView.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 21/2/21.
//

import SwiftUI
import Charts

struct HistoricalPriceView: View {
    var symbol: String
    var chartHeight: CGFloat
    @State private var historicalPrices = [HistoricalPriceModel]()
    
    var body: some View {
        VStack {
            let (colour, prices) = prepareChart()
            Chart(data: prices)
                .frame(height: chartHeight)
                .chartStyle(AreaChartStyle(.quadCurve, fill:
                                            LinearGradient(gradient: .init(colors: [colour.opacity(0.5), colour.opacity(0.2)]),
                                                           startPoint: .top,
                                                           endPoint: .bottom)))
        }
        .onAppear {
            request(url: getUrl(), model: [HistoricalPriceModel].self) { self.historicalPrices = $0 }
        }
    }
    
    private func getUrl() -> String {
        let baseUrl = Bundle.main.infoDictionary?["IEX_URL"] as? String ?? "Empty url"
        let apiKey = Bundle.main.infoDictionary?["IEX_API"] as? String ?? "Empty key"
        let url = "\(baseUrl)/stock/\(symbol)/chart/1m?chartCloseOnly=true&token=\(apiKey)"
        
        return url
    }
    
    private func prepareChart() -> (Color, [Double]) {
        if !historicalPrices.isEmpty {
            // Historical is been requested and successfully received
            let prices = historicalPrices.map { $0.close } // Close prices array (for chart)
            // Modify chart colour depending on % change over time
            // If it's < 0 -> lost value -> red
            var colour: Color = .red
            let changeOverTime = historicalPrices.map { $0.changeOverTime }.last
            if changeOverTime! >= 0 {
                colour = .green
            }
            
            return (colour, normalize(prices))
        }
        
        // Handle error here after x seconds of requesting.
        
        return (.blue, [Double]())
    }
}

struct HistoricalPriceView_Previews: PreviewProvider {
    static var previews: some View {
        HistoricalPriceView(symbol: "aapl", chartHeight: 200)
    }
}
