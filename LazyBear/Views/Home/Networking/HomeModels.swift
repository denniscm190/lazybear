//
//  SectorPerformanceModel.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 30/3/21.
//

import SwiftUI

struct SectorPerformanceModel: Codable, Hashable {
    var name: String
    var performance: Double
    var lastUpdated: Int
}


struct CompanyRowModel: Codable, Hashable {
    var symbol: String
    var companyName: String
    var latestPrice: Double
    var changePercent: Double
}


// Model prepared with batch
struct IntradayPricesArray: Codable {
    var intradayPrices: [IntradayPricesModel]

    // Change key name
    private enum CodingKeys : String, CodingKey {
           case intradayPrices = "intraday-prices"
       }
}

struct IntradayPricesModel: Codable {
    var open: Double?
}


struct TradingDatesModel: Codable {
    var date: String

}
