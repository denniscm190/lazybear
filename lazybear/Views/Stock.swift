//
//  Stock.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 25/1/21.
//

import SwiftUI

/*
 Show real-time prices and LineChart of historical stock prices.
 */

struct Stock: View {
    var name: String
    var symbol: String
    var lineChartHeight: CGFloat
    @EnvironmentObject var apiManager: ApiManager

    // Picker
    @State var periods = ["1W", "1M", "3M", "6M", "1Y", "2Y", "5Y"]
    @State var selectedPeriod = 2
    
    // API job variables
    @State private var url = String() {
        didSet { request(url: url, model: [HistoricalPricesModel].self) { self.data = $0 } }}
    
    @State private var data = [HistoricalPricesModel]() { didSet { self.showingLineChart = true }}
    @State private var showingLineChart = false
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Stock")
                .fontWeight(.semibold)
                .modifier(Title())
            
            Divider()
            HStack {
                Price(symbol: symbol, showHorizontal: true)
                    .padding(.leading)
                
                Spacer()
            }
            
            Divider()
            Group {
                Selection(items: periods, selected: $selectedPeriod)
                    .onChange(of: selectedPeriod, perform: { (value) in
                        getUrl(range: periods[selectedPeriod])
                    })
                
                let prices = data.map { $0.close ?? 0 }
                if showingLineChart {
                    // Normalize prices to fill the entira graph from 0 to 1
                    let normalPrices = normalize(prices)
                    LineChart(dataPoints: normalPrices, lineColor: colorLineChart(prices: prices) ? .green : .red, lineWidth: 2)
                        .frame(height: lineChartHeight)
                }
            }
            .padding([.leading, .trailing])
        }
        .onAppear { getUrl(range: periods[selectedPeriod]) }
    }
    
    // Create endpoint
    private func getUrl(range: String) {
        var range = range
        let baseUrl = apiManager.results[apiManager.option].url ?? ""
        let token = apiManager.results[apiManager.option].key ?? ""
        
        // Normally every point in the graph is a day, so if a short period is called,
        // it will be shown so many points in the graph and will be ugly => If a short period
        // is called => call 5dm or 1mm which shows points every 15 and 30 minutes
        
        if periods[selectedPeriod] == "1W" { range = "5dm" }
        if periods[selectedPeriod] == "1M" { range = "1mm" }
        let path = "/stable/stock/\(symbol)/chart/\(range)?chartCloseOnly=true&includeToday=false&token="
        
        self.url = baseUrl + path + token
   }
    
    // If start price < end price => profit => green color
    private func colorLineChart(prices: [Double]) -> Bool {
        let startPrice = prices.first ?? 0
        let endPrice = prices.last ?? 1
        
        if startPrice < endPrice {
            return true
        } else {
            return false
        }
    }
}

struct Stock_Previews: PreviewProvider {
    static var previews: some View {
        Stock(name: "apple inc", symbol: "aapl", lineChartHeight: 300)
    }
}
