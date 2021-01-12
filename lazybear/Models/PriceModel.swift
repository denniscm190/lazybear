//
//  Prices.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 3/1/21.
//

import SwiftUI

struct PriceModel: Codable {
    var close: Double
    var date: String
    var symbol: String
    var volume: Float
    var changePercent: Double
}
