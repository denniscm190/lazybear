//
//  CompanyModel.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 14/6/21.
//

import SwiftUI

struct CompanyModel: Codable, Hashable {
    var symbol: String
    var companyName: String
    var latestPrice: Double?
    var changePercent: Double?
    var intradayPrices: [Double]
}
