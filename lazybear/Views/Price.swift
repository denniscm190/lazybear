//
//  Price.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 27/1/21.
//

import SwiftUI
import CloudKit

struct Price: View {
    @State var symbol: String
    
    @State var url = String() { didSet { giveMePrices() }}
    @State var showingView = false
    
    @State var latestPrice = Float()
    @State var changePercent = Double() { didSet { self.showingView = true }}
    
    let iexApi = IexApi()  // Request api function
    let timer = Timer.publish(every: 10, on: .main, in: .common).autoconnect()  // Set recurrent price request
    
    @EnvironmentObject var apiAccess: ApiAccess
    
    var body: some View {
        VStack {
            if self.showingView {
                Text("\(latestPrice, specifier: "%.2f")")
                    //.onReceive(timer) { _ in giveMePrices() }
            }
        }
        .onAppear { getUrl() }
    }
    
    private func getUrl() {
        let baseUrl = apiAccess.results[1].url ?? ""  // 1 -> Sandbox / 2 -> Production
        let token = apiAccess.results[1].key ?? ""
        let path = iexApi.getPath(version: .stable, stock: .symbol(company: symbol), endpoint: .quote, range: nil, parameters: nil)
        self.url = baseUrl + path + token
    }
    
    private func giveMePrices() {
        iexApi.request(url: url, model: QuoteModel.self) { result in
            self.latestPrice = result.latestPrice
            self.changePercent = result.changePercent
        }
    }
}

struct Price_Previews: PreviewProvider {
    static var previews: some View {
        Price(symbol: "AAPL")
    }
}
