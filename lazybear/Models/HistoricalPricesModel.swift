//
//  Prices.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 3/1/21.
//

import Foundation

struct HistoricalPricesModel: Codable {
    var date: String
    var close: Double
    var volume: Float?
    var change: Double?
    var changePercent: Double?
    var changeOverTime: Double?
}

