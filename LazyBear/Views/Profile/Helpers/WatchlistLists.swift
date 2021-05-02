//
//  WatchlistLists.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 2/5/21.
//

import SwiftUI
import CoreData

struct WatchlistLists: View {
    @ObservedObject var profile: Profile
    var watchlistCompanies: [WatchlistCompany]
    
    var body: some View {
        Text("Hello, World!")
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
}
