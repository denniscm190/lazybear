//
//  StockAndNews.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 7/2/21.
//

import SwiftUI

struct StockAndNews: View {
    var name: String
    var symbol: String
    
    var body: some View {
        GeometryReader { geo in
            ScrollView {
                VStack(alignment: .leading) {
                    Stock(name: name, symbol: symbol, lineChartHeight: geo.size.height*0.2)
                        .padding(.bottom)
                    
                    News(symbol: symbol)
                }
            }
        }
    }
}

struct StockAndNews_Previews: PreviewProvider {
    static var previews: some View {
        StockAndNews(name: "apple inc", symbol: "aapl")
    }
}
