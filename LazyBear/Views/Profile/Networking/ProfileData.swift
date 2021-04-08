//
//  ProfileData.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 5/4/21.
//

import SwiftUI

class ProfileData: ObservableObject {
    @Published var showView = false
    
    @Published var watchlists = [String(): [CompanyQuoteModel]()]
    @Published var intradayPrices = [String(): [IntradayPricesResult]()]
    
    private let baseUrl = Bundle.main.infoDictionary?["IEX_URL"] as? String ?? "Empty url"
    private let apiKey = Bundle.main.infoDictionary?["IEX_API"] as? String ?? "Empty key"
    
    func get(_ watchlistCompanies: FetchedResults<WatchlistCompany>) {
        let dispatchGroup = DispatchGroup()
        var url = String()
        
        let watchlistSymbols = watchlistCompanies.map { $0.symbol }  // Map watchlist symbols
        
        // 1. REQUEST LATEST PRICE OF THE COMPANIES IN THE WATCHLIST CORE DATA
        url = "\(baseUrl)/stock/market/batch?symbols="
        
        // If there are no companies in Core Data, do not request
        if !watchlistCompanies.isEmpty {
            var counter = 0
            for symbol in watchlistSymbols {  // Iterate watchlist symbols
                counter += 1
                
                // Append symbols to the URL to make the batch request
                if counter == 1 {
                    url += symbol
                } else {
                    url += ",\(symbol)"
                }
            }
            
            url += "&types=quote&token=\(apiKey)"
            genericRequest(url: url, model: [String: CompanyQuoteBatch].self) { dict in
                // Iterate symbols in the Batch request (Keys of the dictionary response)
                for symbol in dict.keys {
                    // Get index of the requested symbol in the watchlist symbol array
                    let index = watchlistSymbols.firstIndex(of: symbol)
                    
                    // Get watchlist name of that symbol
                    let watchlistName = watchlistCompanies[index!].watchlist
                    
                    // Append the CompanyQuote response to a dictionary with key as the watchlist name. Not trivial
                    // First create a object of the company I want to add to the dict
                    let newCompany = dict[symbol]?.quote
                    
                    // Second, get an array of the values in the watchlist key
                    if var companiesInWatchlist = self.watchlists[watchlistName] {
                        // Third, append the new value to that array
                        companiesInWatchlist.append(newCompany!)
                        
                        // Finally, append the updated array to the key dict
                        self.watchlists[watchlistName] = companiesInWatchlist
                    } else {
                        // If it's nil create the array and add it to dict
                        let initCompanyArray: [CompanyQuoteModel] = [newCompany!]
                        self.watchlists[watchlistName] = initCompanyArray
                    }
                    
                    print(self.watchlists)
                    
                }
            }
        } else {
            self.showView = true
        }
    }
}


struct CompanyQuoteBatch: Codable {
    var quote: CompanyQuoteModel
}
