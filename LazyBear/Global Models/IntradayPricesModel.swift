//
//  IntradayPricesModel.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 3/4/21.
//

import SwiftUI

struct IntradayPricesBatch: Codable {
    var intradayprices: [IntradayPricesResult]
}

struct IntradayPricesResult: Codable {
    var open: Double?
}
