//
//  Watchlist.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 25/1/21.
//

import SwiftUI
import CloudKit

/*
 If Watchlist is empty => show placeholder. Else show watchlist.
 */

struct Watchlist: View {
    // CoreData variables
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(entity: WatchlistData.entity(), sortDescriptors: [])
    var watchlistData: FetchedResults<WatchlistData> // List
    
    var body: some View {
        NavigationView {
            VStack {
                if watchlistData.count > 0 {
                    List {
                        Section(header: Text("Watchlist")) {
                            ForEach(watchlistData) { company in
                                WatchlistRow(watchlistData: company)
                            }
                            // Swipe to delete a company
                            .onDelete { indexSet in deleteWatchlist(indexSet: indexSet) }
                        }
                    }
                    .toolbar { EditButton() }
                } else {
                    Placeholder(title: "Seems that your watchlist is empty!", text: "Search and add a company.")
                }
            }
            .navigationBarTitle("Watchlist", displayMode: .inline)
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
  
    // Delete a company from watchlist
    func deleteWatchlist(indexSet: IndexSet) {
        for index in indexSet {
            viewContext.delete(watchlistData[index])
        }
        do {
            try viewContext.save()
            print("Company deleted")
        } catch {
            print(error.localizedDescription)
        }
    }
}

struct Watchlist_Previews: PreviewProvider {
    static var previews: some View {
        Watchlist()
    }
}
