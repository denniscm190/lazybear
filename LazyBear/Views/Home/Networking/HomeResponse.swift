//
//  HomeResponse.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 11/4/21.
//

import SwiftUI

struct HomeResponse: Codable {
  var intradayPrices: [String: [IntradayPriceModel]]?
  var latestCurrencies: [String: CurrencyModel]?
  var lists: ListsModel?
  var sectorPerformance: [SectorPerformanceModel]?
  var tradingDates: [TradingDatesModel]?
  
  private enum CodingKeys : String, CodingKey {
        case intradayPrices = "intraday_prices"
        case latestCurrencies = "latest_currencies"
        case lists
        case sectorPerformance = "sector_performance"
        case tradingDates = "trading_dates"
    }
}


struct ListsModel: Codable {
  var mostactive: [String: QuoteModel]?
  var gainers: [String: QuoteModel]?
  var losers: [String: QuoteModel]?
}
