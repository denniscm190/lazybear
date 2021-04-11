//
//  QuoteModel.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 11/4/21.
//

import SwiftUI

struct QuoteModel: Codable, Hashable {
    var companyName: String
    var symbol: String
    var latestPrice: Double
    var changePercent: Double
}
