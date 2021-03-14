//
//  HistoricalPriceView.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 21/2/21.
//

import SwiftUI

struct ChartView: View {
    var symbol: String
    var chartHeight: CGFloat
    @State private var historicalPrices = [HistoricalPriceModel]()
   
    // Date picker
    var period = ["1W", "1M", "3M", "6M", "1Y", "2Y", "5Y"]
    @State var selectedPeriod = 2
    
    var body: some View {
        VStack {
            DateSelection(period: period, selectedperiod: $selectedPeriod)
                .padding(.horizontal)
                .onChange(of: selectedPeriod, perform: { (value) in
                    let url = getUrl(endpoint: .historicalPrices, symbol: symbol, range: period[value])
                    request(url: url, model: [HistoricalPriceModel].self) { self.historicalPrices = $0 }
                })
            

        }
        .onAppear {
            let url = getUrl(endpoint: .historicalPrices, symbol: symbol, range: "3m")
            request(url: url, model: [HistoricalPriceModel].self) { self.historicalPrices = $0 }
        }
    }
}

struct HistoricalPriceView_Previews: PreviewProvider {
    static var previews: some View {
        ChartView(symbol: "aapl", chartHeight: 200)
    }
}
