//
//  IntradayPricesModel.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 31/3/21.
//

import SwiftUI

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
