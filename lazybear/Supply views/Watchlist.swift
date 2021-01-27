//
//  Watchlist.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 25/1/21.
//

import SwiftUI
import CloudKit

struct Watchlist: View {
    @Environment(\.managedObjectContext) private var viewContext  // Core data
    @FetchRequest(entity: WatchlistCompany.entity(), sortDescriptors: [])  // Core data
    var companies: FetchedResults<WatchlistCompany>  // Fetch core data
    
    let cloud = CloudKitManager()
    @State private var showingView = false
    @State var cloudResults = [CKRecord]() {
        didSet {
            self.showingView = true
        }
    }
    
    var body: some View {
        if self.showingView {
            List {
                EditButton()
                let url = cloudResults[0].object(forKey: "url") as! String
                ForEach(companies) { company in
                    WatchlistRow(company: company, url: url)
                    
                }
                // Delete from persistent storage
                .onDelete { indexSet in deleteWatchlist(indexSet: indexSet) }
            }
        } else {
            Spacer()
                .onAppear {
                    cloud.query(recordType: "API", recordName: "iexLogo") { self.cloudResults = $0 }
                }
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
