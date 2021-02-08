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
    @FetchRequest(entity: WatchlistData.entity(), sortDescriptors: [])
    var watchlistData: FetchedResults<WatchlistData>
    // <--------- Core Data --------->
    
    var body: some View {
        let watchlistSymbols = watchlistData.map { $0.symbol }
        let alertView = SPAlertView(title: "Company added", preset: .done)
        
        if !watchlistSymbols.contains(symbol) {
            Button(action: {
                addWatchlist()
                alertView.present(haptic: .success)
            }) {
                Text("Add")
            }
        }
    }
    
    private func addWatchlist() {
        let watchlistData = WatchlistData(context: viewContext)
        watchlistData.name = name
        watchlistData.symbol = symbol
        do {
            try viewContext.save()
            print("Company saved.")
        } catch {
            print(error.localizedDescription)
        }
    }
}
/*
struct AddWatchlist_Previews: PreviewProvider {
    static var previews: some View {
        AddWatchlist(symbol: "aapl", name: "apple")
    }
}
 */
