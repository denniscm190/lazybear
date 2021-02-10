//
//  AddWatchlist.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 6/2/21.
//

import SwiftUI
import SPAlert

/*
 If the company is not in watchlist => Add it
 */

struct AddWatchlist: View {
    var symbol: String
    var name: String
    
    // CoreData variables
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(entity: WatchlistData.entity(), sortDescriptors: [])
    var watchlistData: FetchedResults<WatchlistData>
    
    var body: some View {
        let watchlistSymbols = watchlistData.map { $0.symbol }  // Array of symbols
        let alertView = SPAlertView(title: "Company added", preset: .done)  // Create HUD
        
        // If symbol is not in the array of symbols => show add button
        if !watchlistSymbols.contains(symbol) {
            Button(action: {
                addWatchlist()
                alertView.present(haptic: .success)  // Show HUD when added
            }) {
                Text("Add")
            }
        }
    }
    
    // Add to watchlist
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

struct AddWatchlist_Previews: PreviewProvider {
    static var previews: some View {
        AddWatchlist(symbol: "aapl", name: "apple")
    }
}
 
