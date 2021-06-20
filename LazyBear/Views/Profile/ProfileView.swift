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
                    if let apiCompanies = profile.data.quotes {
                        let watchlistsNames = Array(Set(watchlistCompanies.map { $0.watchlistName })).sorted()  /// Get watchlistsNames in Core Data
                        ForEach(watchlistsNames, id: \.self) { watchlistName in
                            let companies = createWatchlistRow(apiCompanies, watchlistCompanies, watchlistName)
                            ProfileStockRow(watchlistName: watchlistName, companies: companies)
                        }
                        .listRowInsets(EdgeInsets())
                        .onAppear {  /// Request API again when Core Data changes to update the list
                            refreshList()
                        }
                    }
                }
                .onAppear { self.timer = Timer.publish(every: 10, on: .main, in: .common).autoconnect() }  /// Start timer
                .onDisappear { self.timer.upstream.connect().cancel() }  /// Stop timer
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
     At this point, we have the API response with the watchlist companies data requested and received. Now, we have to extract from the API response
     the companies within the selected watchlist. To do that, we should do the following:
     1) Get an array of all the symbols within the specified watchlist.
     2) Iterate over watchlistSymbols and return the company (QuoteModel object) from apiCompanies that matches.
     3) Append this symbol to a new array.
     */
    private func createWatchlistRow(_ apiCompanies: [CompanyModel], _ watchlistCompanies: FetchedResults<WatchlistCompany>, _ watchlistName: String) -> [CompanyModel] {
        let watchlistSymbols = watchlistCompanies.filter({ $0.watchlistName == watchlistName }).map { $0.symbol }  /// Get symbols contained in watchlistsName (Core Data)
        
        var companies = [CompanyModel]()
        for watchlistSymbol in watchlistSymbols {
            let company = apiCompanies.first(where: { $0.symbol == watchlistSymbol })
            companies.append(company!)
        }
        
        return companies
    }
    
    /*
     When a company is added to a watchlist or a new watchlist is created -> call function
     to make the API request and refresh correctly the list
     */
    private func refreshList() {
        if profile.data.quotes!.count < watchlistCompanies.count {
            prepareUrl(.initial)
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
            let url = "https://api.lazybear.app/profile/type=initial/symbols=\(symbolString)"
            profile.request(url, .initial)
            
        default:
            let url = "https://api.lazybear.app/profile/type=streaming/symbols=\(symbolString)"
            profile.request(url, .streaming)
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
