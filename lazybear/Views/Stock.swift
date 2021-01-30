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
    
    @State var selectedPeriod = 2
    
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
            LineView(data: [50, 60, 40, 20, 30, 40, 30])
        }
        .padding([.leading, .trailing])
    }
}

struct Stock_Previews: PreviewProvider {
    static var previews: some View {
        Stock(name: "apple inc", symbol: "aapl")
    }
}
