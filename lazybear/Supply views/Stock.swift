//
//  Stock.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 25/1/21.
//

import SwiftUI

struct Stock: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    var body: some View {
        Text("Hello, World!")
    }
    
    func addWatchlist(name: String, symbol: String) {
        let watchlistCompany = WatchlistCompany(context: viewContext)
        watchlistCompany.name = name
        watchlistCompany.symbol = symbol
        do {
            try viewContext.save()
            print("Company saved.")
        } catch {
            print(error.localizedDescription)
        }
    }
}

struct Stock_Previews: PreviewProvider {
    static var previews: some View {
        Stock()
    }
}
