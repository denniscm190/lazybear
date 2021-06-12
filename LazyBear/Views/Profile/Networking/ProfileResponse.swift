//
//  ProfileResponse.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 16/4/21.
//

import SwiftUI

struct ProfileResponse: Codable {
  var intradayPrices: [String: [Double]]?
  var quotes: [String: QuoteModel]?
  
    private enum CodingKeys : String, CodingKey {
        case intradayPrices = "intraday_prices"
        case quotes
    }
}
