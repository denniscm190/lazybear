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
    
    // Set recurrent price request
    @State private var timer = Timer.publish(every: 10, on: .main, in: .common).autoconnect()

    var body: some View {
        if profile.showView {
            NavigationView {
                List {
                    // Get Watchlist names -> Create rows for each watchlist -> in each row, show companies
                    let watchlists = Set(watchlistCompanies.map { $0.watchlist })  // Set -> avoid duplicates names
                    
                    ForEach(Array(watchlists).sorted(), id: \.self) { listName in
                        let symbols = watchlistCompanies.filter({ $0.watchlist == listName }).map { $0.symbol }
                        
                        if let companies = profile.data.quotes {
                            // Select from API requested companies only the ones withing the watchlist
                            let list = companies.filter({ symbols.contains($0.key) })
                            StockRow(listName: listName, list: list, intradayPrices: profile.data.intradayPrices, addOnDelete: true)
                        }
                    }
                    .listRowInsets(EdgeInsets())
                    .onAppear {  // Refresh API requested companies when Core Data changes
                        refreshList()
                    }
                }
                .onAppear { self.timer = Timer.publish(every: 10, on: .main, in: .common).autoconnect() }  // Start timer
                .onReceive(timer) { _ in prepareUrl(isInitRequest: false) }
                .onDisappear { self.timer.upstream.connect().cancel() }  // Stop timer
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
     Get symbols in watchlists -> Prepare url -> Request
     */
    private func prepareUrl(isInitRequest: Bool) {
        if watchlistCompanies.isEmpty {
            profile.showView = true
        } else {
            let symbols = watchlistCompanies.map { $0.symbol }
            var typeRequest = "streaming"
            if isInitRequest { typeRequest = "init" }
            var url = "https://api.lazybear.app/profile/type=\(typeRequest)/symbols="

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
     When a company is added to a watchlist or a new watchlist is created -> call function
     to make the API request and refresh correctly the list
     */
    private func refreshList() {
        print("Companies in watchlist -> \(watchlistCompanies.count)")
        print("Companies requested -> \(profile.data.quotes!.count)")
        
        if profile.data.quotes!.count < watchlistCompanies.count {
            prepareUrl(isInitRequest: true)
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
