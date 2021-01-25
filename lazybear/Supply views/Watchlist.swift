//
//  Watchlist.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 25/1/21.
//

import SwiftUI

struct Watchlist: View {
    @Environment(\.managedObjectContext) private var viewContext  // Core data
    @FetchRequest(entity: WatchlistCompany.entity(), sortDescriptors: [])  // Core data
    var companies: FetchedResults<WatchlistCompany>  // Fetch core data
    
    var body: some View {
        List {
            ForEach(companies) { company in
                WatchlistRow(company: company)
                
            }
            // Delete from persistent storage
            .onDelete { indexSet in delete(indexSet: indexSet) }
        }
    }
    
    func delete(indexSet: IndexSet) {
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
