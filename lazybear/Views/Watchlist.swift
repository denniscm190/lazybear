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
    @FetchRequest(entity: WatchlistCompany.entity(), sortDescriptors: [])
    var companies: FetchedResults<WatchlistCompany>  // Fetch core data
    
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("Watchlist")) {
                    ForEach(companies) { company in
                        WatchlistRow(company: company)
                    }
                    .onDelete { indexSet in deleteWatchlist(indexSet: indexSet) }  // Delete from persistent storage
                }
            }
            .navigationBarTitle("Watchlist", displayMode: .inline)
            .toolbar { EditButton() }
            
        }.navigationViewStyle(StackNavigationViewStyle())
    }
    
    func deleteWatchlist(indexSet: IndexSet) {
        for index in indexSet {
            viewContext.delete(companies[index])
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
