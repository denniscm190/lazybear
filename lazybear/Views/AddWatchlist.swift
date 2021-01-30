//
//  AddWatchlist.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 30/1/21.
//

import SwiftUI

struct AddWatchlist: View {
    var name: String
    var symbol: String
    
    @Environment(\.managedObjectContext) private var viewContext
    
    var body: some View {
        Button(action: { addWatchlist(name: name, symbol: symbol) }) {
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                Text("Add to watchlist")
                    .foregroundColor(.white)
            }
            .frame(width: 150)
        }
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

struct AddWatchlist_Previews: PreviewProvider {
    static var previews: some View {
        AddWatchlist(name: "apple inc", symbol: "aapl")
    }
}
