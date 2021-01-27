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
    let cloud = CloudKitManager()
    
    var body: some View {
        List {
            EditButton()
            let url = cloud.query(recordType: "API", recordName: "iexLogo")
            ForEach(companies) { company in
                WatchlistRow(company: company, url: "")
                
            }
            // Delete from persistent storage
            .onDelete { indexSet in deleteWatchlist(indexSet: indexSet) }
        }
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
