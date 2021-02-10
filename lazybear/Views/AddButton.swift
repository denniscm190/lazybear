//
//  CreateButton.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 7/2/21.
//

import SwiftUI
import SPAlert

/*
 Generic add button. When tapped many options could be shown. Save to favourite, to watchlist, etc
 */

struct AddButton: View {
    var symbol: String
    var name: String
    
    @State private var showingActionSheet = false
    
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(entity: WatchlistData.entity(), sortDescriptors: [])
    var companies: FetchedResults<WatchlistData>  // Fetch core data
    
    var body: some View {
        Button(action: { self.showingActionSheet = true }) {
            Image(systemName: "plus")
                .imageScale(.large)
                .frame(width: 30, height: 30)  // Increase tappable area
                .actionSheet(isPresented: $showingActionSheet) { alert() }
        }
    }
    
    // Create Action sheet
    private func alert() -> ActionSheet {
        var buttons: [ActionSheet.Button] = [.cancel(Text("Cancel")) { self.showingActionSheet = false }]
        
        // If the company is already in watchlist => show Remove from watchlist instead
        let watchlistSymbols = companies.map { $0.symbol }
        
        if watchlistSymbols.contains(symbol) {
            buttons.append(.destructive(Text("Remove from watchlist")) { removeWatchlist() } )
        } else {
            buttons.append(.default(Text("Add to wachtlist")) { addWatchlist() })
        }
        
        let action = ActionSheet(
            title: Text("Options"),
            buttons: buttons)
        
        return action
    }
    
    // Save company to Watchlist
    private func addWatchlist() {
        let alertView = SPAlertView(title: "Added to watchlist", preset: .done)
        let watchlistCompany = WatchlistData(context: viewContext)
        watchlistCompany.name = name
        watchlistCompany.symbol = symbol
        do {
            try viewContext.save()
            print("Added to watchlist")
            alertView.present(haptic: .success)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    // Remove company from watchlist
    func removeWatchlist() {
        let alertView = SPAlertView(title: "Removed from watchlist", preset: .done)
        let watchlistSymbols = companies.map { $0.symbol }
        let index = watchlistSymbols.firstIndex(of: symbol)
        
        viewContext.delete(companies[index!])
        do {
            try viewContext.save()
            print("Deleted from watchlist")
            alertView.present(haptic: .success)
        } catch {
            print(error.localizedDescription)
        }
    }
}


struct CreateButton_Previews: PreviewProvider {
    static var previews: some View {
        AddButton(symbol: "aapl", name: "apple inc")
    }
}
