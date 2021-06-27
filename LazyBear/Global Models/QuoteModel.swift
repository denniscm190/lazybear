//
//  QuoteModel.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 21/4/21.
//

import SwiftUI

struct QuoteModel: Codable {
    var companyName: String
    var latestPrice: Double?
    var changePercent: Double?
    var intradayPrices: [Double]?
}
