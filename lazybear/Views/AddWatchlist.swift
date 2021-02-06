//
//  AddWatchlist.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 6/2/21.
//

import SwiftUI
import SPAlert

struct AddWatchlist: View {
    var symbol: String
    var name: String
    
    // <--------- Core Data --------->
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(entity: WatchlistCompany.entity(), sortDescriptors: [])
    var companies: FetchedResults<WatchlistCompany>
    // <--------- Core Data --------->
    
    var body: some View {
        let watchSymbols = companies.map { $0.symbol }
        let alertView = SPAlertView(title: "Company added", preset: .done)
        
        if !watchSymbols.contains(symbol) {
            Button(action: {
                addWatchlist(name: name, symbol: symbol)
                alertView.present(haptic: .success)
            }) {
                Text("Add")
            }
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
        AddWatchlist(symbol: "aapl", name: "apple")
    }
}
