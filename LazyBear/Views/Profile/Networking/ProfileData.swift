//
//  ProfileData.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 5/4/21.
//

import SwiftUI

class ProfileData: ObservableObject {
    @Published var companies = [CompanyQuoteModel]()
    @Published var showView = false
    @FetchRequest(entity: WatchlistCompany.entity(), sortDescriptors: [])
    var watchlistCompanies: FetchedResults<WatchlistCompany>
    
    private let baseUrl = Bundle.main.infoDictionary?["IEX_URL"] as? String ?? "Empty url"
    private let apiKey = Bundle.main.infoDictionary?["IEX_API"] as? String ?? "Empty key"
    
    private func get() {
        var url = "\(baseUrl)/stock/market/batch?symbols="
        
        if !watchlistCompanies.isEmpty {
            let symbols = watchlistCompanies.map { $0.symbol }
            for symbol in symbols {
                if symbols.firstIndex(of: symbol) == 0 {
                    url += symbol!
                } else {
                    url += "\(symbol!),"
                }
            }
            
            url = "&types=quote&token=\(apiKey)"
            genericRequest(url: url, model: [String: CompanyQuoteBatch].self) {
                print($0)
                self.showView = true
            }
        } else {
            self.showView = true
        }
    }
}


struct CompanyQuoteBatch: Codable {
    var quote: CompanyQuoteModel
}
