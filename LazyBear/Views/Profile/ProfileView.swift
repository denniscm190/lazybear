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
    @State private var timer = Timer.publish(every: 10, on: .main, in: .common).autoconnect()  /// Set recurrent price request

    var body: some View {
        if profile.showView {
            NavigationView {
                List {
                    /*
                     Get Watchlist names -> Create rows for each watchlist -> in each row, show companies
                     */
                    let watchlists = Set(watchlistCompanies.map { $0.watchlist })  /// Set -> avoid duplicates names
                    ForEach(Array(watchlists).sorted(), id: \.self) { listName in
                        let symbols = watchlistCompanies.filter({ $0.watchlist == listName }).map { $0.symbol }
                        if let companies = profile.data.quotes {
                            let list = companies.filter({ symbols.contains($0.key) })  /// From API response select the companies within the specified watchlist
                            StockRow(listName: listName, list: list, intradayPrices: profile.data.intradayPrices, addOnDelete: true)
                        }
                    }
                    .listRowInsets(EdgeInsets())
                    .onAppear {  /// Request API again when Core Data changes to update the list
                        refreshList()
                    }
                }
                .onAppear { self.timer = Timer.publish(every: 10, on: .main, in: .common).autoconnect() }  // Start timer
                .onDisappear { self.timer.upstream.connect().cancel() }  // Stop timer
                .onReceive(timer) { _ in
                    if !showCreateNewWatchlist {
                        prepareUrl(.streaming)
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
                .onAppear { prepareUrl(.initial) }
        }
    }
    
    /*
     Get symbols in watchlists (Core Data) -> Prepare url -> Request
     */
    private func prepareUrl(_ requestType: RequestType) {
        let symbols = watchlistCompanies.map { $0.symbol }
        
        var symbolString = ""
        for (index, symbol) in symbols.enumerated() {
            if index == 0 {
                symbolString += symbol
            } else {
                symbolString += ",\(symbol)"
            }
        }
        
        switch requestType {
        case .initial:
            let url = "https://api.lazybear.app/profile/type=init/symbols=\(symbolString)"
            profile.request(url, .initial)
            
        default:
            let url = "https://api.lazybear.app/profile/type=streaming/symbols=\(symbolString)"
            profile.request(url, .streaming)
        }
    }
        
    
    /*
     When a company is added to a watchlist or a new watchlist is created -> call function
     to make the API request and refresh correctly the list
     */
    private func refreshList() {
//        print("Companies in watchlist -> \(watchlistCompanies.count)")
//        print("Companies requested -> \(profile.data.quotes!.count)")
        
        if profile.data.quotes!.count < watchlistCompanies.count {
            prepareUrl(.initial)
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
