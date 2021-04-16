//
//  ProfileResponse.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 16/4/21.
//

import SwiftUI

struct ProfileResponse: Codable {
    var intradayPrices: [String: NestedIntradayPricesModel]?  // String is each company symbol
    var quotes: [String: NestedQuoteModel]?  // String is each company symbol
    
    private enum CodingKeys : String, CodingKey {
        case intradayPrices = "intraday_prices"
        case quotes
    }
}


struct NestedQuoteModel: Codable {
    var nestedQuoteModel: QuoteModel
    
    private enum CodingKeys : String, CodingKey {
        case nestedQuoteModel = "quote"
    }
}
