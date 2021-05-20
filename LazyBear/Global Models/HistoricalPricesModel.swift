//
//  HistoricalPricesModel.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 16/5/21.
//

import SwiftUI

struct HistoricalPricesModel: Codable {
    var close: Double
    var date: String
    var minute: String?
}
