//
//  Stock.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 25/1/21.
//

import SwiftUI

struct Stock: View {
    var name: String
    var symbol: String
    var lineChartHeight: CGFloat
    @EnvironmentObject var apiAccess: ApiAccess

    // <--------- Picker --------->
    var period = ["1W", "1M", "3M", "6M", "1Y", "2Y", "5Y"]
    @State var selectedPeriod = 2
    // <--------- Picker --------->
    
    // <--------- API Job --------->
    @State private var url = String() {
        didSet { request(url: url, model: [HistoricalPricesModel].self) { self.data = $0 } }}
    
    @State private var data = [HistoricalPricesModel]() { didSet { self.showingLineChart = true }}
    @State private var showingLineChart = false
    // <--------- API Job --------->
    
    // <--------- Core Data --------->
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(entity: WatchlistCompany.entity(), sortDescriptors: [])
    var companies: FetchedResults<WatchlistCompany>
    // <--------- Core Data --------->
    
    var body: some View {
        VStack {
            Divider()
            HStack {
                Price(symbol: symbol, showVertical: true)
                Spacer()
                let watchSymbols = companies.map { $0.symbol }
                if !watchSymbols.contains(symbol) {
                    AddWatchlist(name: name, symbol: symbol)
                }
            }
            
            Divider()
            DateSelection(selectedperiod: $selectedPeriod)
                .onChange(of: selectedPeriod, perform: { (value) in
                    getUrl(range: period[selectedPeriod])
                })
            
            let prices = data.map { $0.close }
            if showingLineChart {
                let normalPrices = normalize(prices)
                LineChart(dataPoints: normalPrices, lineColor: colorLineChart(prices: prices) ? .green : .red, lineWidth: 2)
                    .frame(height: lineChartHeight)
            }
        }
        .padding([.leading, .trailing])
        .onAppear { getUrl(range: period[selectedPeriod]) }
    }
    
    private func getUrl(range: String) {
        var range = range
        
        // 1 -> Sandbox / 2 -> Production
        let baseUrl = apiAccess.results[1].url ?? ""
        let token = apiAccess.results[1].key ?? ""
        if period[selectedPeriod] == "1W" { range = "5dm" }
        if period[selectedPeriod] == "1M" { range = "1mm" }
        let path = "/stable/stock/\(symbol)/chart/\(range)?chartCloseOnly=true&includeToday=false&token="
        
        self.url = baseUrl + path + token
   }
    
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
