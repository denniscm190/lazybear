//
//  ChartResponse.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 15/5/21.
//

import SwiftUI

struct ChartResponse: Codable {
    var historicalPrices: [HistoricalPricesModel]?
    var quote: [String: QuoteModel]?
    var latestNews: [LatestNewsModel]?
    var keyStats: KeyStatsModel?
}

