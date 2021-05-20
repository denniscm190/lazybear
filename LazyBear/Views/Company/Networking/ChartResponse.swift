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
    
    private enum CodingKeys : String, CodingKey {
        case historicalPrices = "historical_prices"
        case quote
        case latestNews = "latest_news"
    }
}
