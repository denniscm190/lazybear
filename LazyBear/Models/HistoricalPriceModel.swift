//
//  HistoricalPrice.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 21/2/21.
//

import SwiftUI

struct HistoricalPriceModel: Codable {
    var date: String
    var close: Double
    var volume: Int
    var change: Double
    var changePercent: Double
    var changeOverTime: Double

}
