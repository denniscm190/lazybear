//
//  ProfileView.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 4/4/21.
//

import SwiftUI
import CoreData

struct ProfileView: View {
    @ObservedObject var profile = Profile()
    @FetchRequest(entity: WatchlistCompany.entity(), sortDescriptors: [])
    var watchlistCompanies: FetchedResults<WatchlistCompany>
    
    @State private var showCreateNewWatchlist = false

    var body: some View {
        if profile.showView {
            NavigationView {
                List {
                    
                    // Get Watchlist names -> Create rows for each watchlist -> in each row, show companies
                    let watchlists = Set(watchlistCompanies.map { $0.watchlist })  // Set -> avoid duplicates names
                    
                    ForEach(Array(watchlists), id: \.self) { watchlist in
                        let symbols = watchlistCompanies.filter({ $0.watchlist == watchlist }).map { $0.symbol }

                        if let companies = profile.data.quotes {
                            let filteredCompanies = companies.filter({ symbols.contains($0.key) })
                            StockRow(listName: watchlist,
                                     list: filteredCompanies,
                                     intradayPrices: profile.data.intradayPrices,
                                     addOnDelete: true
                            )
                            .onAppear { updateRows(symbols.count, filteredCompanies.count) }
                            .listRowInsets(EdgeInsets())
                        }
                    }
                }
                .navigationTitle("My profile")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button(action: { showCreateNewWatchlist = true }) {
                            Image(systemName: "plus")
                        }
                    }
                }
            }
            .sheet(isPresented: $showCreateNewWatchlist) {
                CreateNewWatchlist()
            }
        } else {
            ProgressView()
                .onAppear { prepareUrl(isInitRequest: true) }
        }
    }
    
    private func prepareUrl(isInitRequest: Bool) {
        if watchlistCompanies.isEmpty {
            profile.showView = true
        } else {
            let symbols = watchlistCompanies.map { $0.symbol }  // Get symbols in watchlists
            var url = "https://api.lazybear.app/profile/type=init/symbols="

            var counter = 0
            for symbol in symbols {
                counter += 1
                if counter == 1 {
                    url += symbol
                } else {
                    url += ",\(symbol)"
                }
            }
            profile.request(url, isInitRequest: isInitRequest)
        }
    }
    
    /*
     If Core Data changes, companies is not updated because the API request is not called ->
     Check if symbols.count (Core Data) is equal to filteredCompanies -> if not -> call API
     */
    private func updateRows(_ numberOfCoreDataCompanies: Int, _ numberOfApiRequestedCompanies: Int) {
        if numberOfCoreDataCompanies != numberOfApiRequestedCompanies {
            prepareUrl(isInitRequest: true)  // Call API
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
