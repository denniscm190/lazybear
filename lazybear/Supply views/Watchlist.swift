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
    
    let cloud = CloudKitManager()
    @State private var cloudFetch = [CKRecord]() { didSet { self.cloudValues() }}
    @State private var cloudResults = [ApiModel]()
    @State private var showingView = false
    
    
    var body: some View {
        if self.showingView {
            ListHeader(header: "Watchlist")
            List {
                ForEach(companies) { company in
                    //WatchlistRow(company: company, url: url)
                }
                .onDelete { indexSet in deleteWatchlist(indexSet: indexSet) }  // Delete from persistent storage
            }
            .onAppear {
                print(cloudResults)
            }
            
        } else {
            Spacer()
                .onAppear { cloud.query(recordType: "API") { self.cloudFetch = $0 } }
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
    
    private func cloudValues() {
        cloudFetch.forEach({ (result) in
            let key = result.object(forKey: "key") as? String
            let name = result.object(forKey: "name") as? String
            let url = result.object(forKey: "url") as? String
            
            let value = ApiModel(key: key, name: name, url: url)
            self.cloudResults.append(value)
        })
        self.showingView = true
    }
}

struct Watchlist_Previews: PreviewProvider {
    static var previews: some View {
        Watchlist()
    }
}
