//
//  CompanyResponse.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 20/6/21.
//

import SwiftUI

struct CompanyResponse: Codable {
    var historicalPrices: [HistoricalPricesModel]?
    var quote: [QuoteModel]?
    var latestNews: [LatestNewsModel]?
    var keyStats: KeyStatsModel?
    var insiderRoster: [InsiderRosterModel]?
    var insiderTransactions: [InsiderTransactionModel]?
}
