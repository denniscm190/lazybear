//
//  HistoricalPrice.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 21/2/21.
//

import SwiftUI

struct HistoricalPriceModel: Codable {
    var date: String
    var minute: String? // Intraday data only
    var close: Double
    var volume: Int
    var change: Double? // Not intraday data only
    var changePercent: Double? // Not intraday data only
    var changeOverTime: Double? // Not intraday data only

}
