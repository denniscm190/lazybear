//
//  SearchData.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 3/4/21.
//

import SwiftUI

class SearchData: ObservableObject {
    @Published var companies = [CompanyQuoteModel]()
    
    private let baseUrl = Bundle.main.infoDictionary?["IEX_URL"] as? String ?? "Empty url"
    private let apiKey = Bundle.main.infoDictionary?["IEX_API"] as? String ?? "Empty key"
    private let symbols = popularCompanies.map { $0.symbol }
    
    func request() {
        var url = "\(baseUrl)/stock/market/batch?symbols="
        
        // Contruct url appending symbols
        for symbol in self.symbols {
            let index = self.symbols.firstIndex(of: symbol)
            if index == 0 {
                url += symbol
            } else {
                url += ",\(symbol)"
            }
        }
        
        // Append final part of the url
        url += "&types=quote&token=\(apiKey)"

        genericRequest(url: url, model: [String:BatchCompanyQuoteModel].self) { dict in
            for key in dict.keys {
                if let company = dict[key] {
                    self.companies.append(company.quote)
                }
            }
        }
    }
}
