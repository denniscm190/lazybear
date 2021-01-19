//
//  Stock.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 2/1/21.
//

import SwiftUI

struct Stock: View {
    var cik: Int
    var symbol: String
    var name: String
    @ObservedObject var historicalPrices = HistoricalPrices()
    
    var body: some View {
        if historicalPrices.showingView {
            GeometryReader { geo in
                VStack {
                    PriceOverview(historicalPrices: historicalPrices)
                    let width = geo.size.width*0.9
                    StockCharts(historicalPrices: historicalPrices, geoWidth: width)
                }
            }
        }
        else {
            VStack{
                Spacer()
                ProgressView()
                Spacer()
            }
            .onAppear {
                print(symbol)
                historicalPrices.request(symbol: symbol)
            }
            .alert(isPresented: $historicalPrices.showingAlert) {
                        Alert(title: Text("There is no data available"),
                              message: Text("We have no data about this company. Try another one."),
                              dismissButton: .default(Text("Got it!")))
            }
        }
    }
}
extension Image {
    func favouriteIcon() -> some View {
        self
            .resizable()
            .frame(width: 25, height: 25)
            .foregroundColor(.yellow)
    }
}

struct Stock_Previews: PreviewProvider {
    static var previews: some View {
        Stock(cik: 320193, symbol: "aapl", name: "apple inc")
    }
}
