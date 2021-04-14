//
//  HomeResponse.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 11/4/21.
//

import SwiftUI

struct HomeResponse: Codable {
    var lists: [String: [QuoteModel]]?  // String is the list type; gainers, losers ...
    var sectorPerformance: [SectorPerformanceModel]?
    var tradingDates: [TradingDatesModel]?
    var intradayPrices: [String: NestedIntradayPricesModel]?  // String is each company symbol
    var latestCurrencies: [String: CurrencyModel]?
    
    private enum CodingKeys : String, CodingKey {
        case lists
        case sectorPerformance = "sector_performance"
        case tradingDates = "trading_dates"
        case intradayPrices = "intraday_prices"
        case latestCurrencies = "latest_currencies"
    }
}


struct NestedIntradayPricesModel: Codable {
    var nestedIntradayPrices: [IntradayPricesModel]
    
    private enum CodingKeys : String, CodingKey {
        case nestedIntradayPrices = "intradayprices"
    }
}
