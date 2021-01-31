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
    
    var period = ["1W", "1M", "3M", "6M", "1Y", "2Y", "5Y"]
    @State var selectedPeriod = 2
    
    @State private var url = String() { didSet { requestHistorical() }}
    @State private var data = [HistoricalPricesModel]() { didSet { self.showingLineChart = true }}
    @State private var showingLineChart = false
    
    let iexApi = IexApi()  // Request api function
    
    @EnvironmentObject var apiAccess: ApiAccess
    
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(entity: WatchlistCompany.entity(), sortDescriptors: [])
    var companies: FetchedResults<WatchlistCompany>  // Fetch core data
    
    var body: some View {
        VStack {
            Divider()
            HStack {
                let watchSymbols = companies.map { $0.symbol }
                if !watchSymbols.contains(symbol) {
                    AddWatchlist(name: name, symbol: symbol)
                }
                
                Spacer()
                Price(symbol: symbol, showVertical: true)
            }
            
            Divider()
            DateSelection(selectedperiod: $selectedPeriod)
                .onChange(of: selectedPeriod, perform: { (value) in
                    getUrl(range: period[selectedPeriod])
                })
            
            let prices = data.map { DataPoint(value: $0.close) }
            LineChart(dataPoints: prices, lineColor: .green, lineWidth: 2)
                .frame(height: 400)
        }
        .padding([.leading, .trailing])
        .onAppear { getUrl(range: period[selectedPeriod]) }
    }
    
    private func getUrl(range: String) {
        let baseUrl = apiAccess.results[1].url ?? ""  // 1 -> Sandbox / 2 -> Production
        let token = apiAccess.results[1].key ?? ""
        let path = iexApi.getPath(version: .stable, stock: .symbol(company: symbol), endpoint: .historicalPrices, range: .period(range: range), parameters: .chartCloseOnly)
        
        self.url = baseUrl + path + token
   }
    
    private func requestHistorical() {
        iexApi.request(url: url, model: [HistoricalPricesModel].self) { self.data = $0 }
    }
}

struct Stock_Previews: PreviewProvider {
    static var previews: some View {
        Stock(name: "apple inc", symbol: "aapl")
    }
}
