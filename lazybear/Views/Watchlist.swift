//
//  Watchlist.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 25/1/21.
//

import SwiftUI
import CloudKit

struct Watchlist: View {
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(entity: WatchlistData.entity(), sortDescriptors: [])
    var watchlistData: FetchedResults<WatchlistData>  // Fetch core data
    
    var body: some View {
        NavigationView {
            VStack {
                if watchlistData.count > 0 {
                    List {
                        Section(header: Text("Watchlist")) {
                            ForEach(watchlistData) { company in
                                WatchlistRow(watchlistData: company)
                            }
                            .onDelete { indexSet in deleteWatchlist(indexSet: indexSet) }  // Delete from persistent storage
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
