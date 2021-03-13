//
//  GetUrl.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 13/3/21.
//

import SwiftUI

enum Endpoint {
    case quote
    case news
    case historicalPrices
    case insiderTransactions
    case insiderSummary
}

func getUrl(endpoint: Endpoint, symbol: String, range: String = "") -> String {
    let baseUrl = Bundle.main.infoDictionary?["IEX_URL"] as? String ?? "Empty url"
    let apiKey = Bundle.main.infoDictionary?["IEX_API"] as? String ?? "Empty key"
    
    switch endpoint {
    case .quote:
        return "\(baseUrl)/stock/\(symbol)/quote?token=\(apiKey)"
    case .news:
        return "\(baseUrl)/stock/\(symbol)/news/last/30?token=\(apiKey)"
    case .historicalPrices:
        return "\(baseUrl)/stock/\(symbol)/chart/\(range)?chartCloseOnly=true&token=\(apiKey)"
    case .insiderTransactions:
        return "\(baseUrl)/stock/\(symbol)/insider-transactions?token=\(apiKey)"
    case .insiderSummary:
        return "\(baseUrl)/stock/\(symbol)/insider-roster?token=\(apiKey)"
    }
}
