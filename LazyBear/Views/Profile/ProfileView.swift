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
    
    @Environment(\.managedObjectContext) private var moc
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
            .fullScreenCover(isPresented: $showCreateNewWatchlist) {
                WatchlistCreator()
                    .environment(\.managedObjectContext, self.moc)
            }
        } else {
            ProgressView()
                .onAppear { prepareUrl(isInitRequest: true) }
        }
    }
    
    /*
     Get symbols in watchlists -> request
     */
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
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
