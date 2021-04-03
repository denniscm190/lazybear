//
//  CompanyQuoteModel.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 30/3/21.
//

import SwiftUI

struct CompanyQuoteModel: Codable, Hashable {
    var companyName: String
    var symbol: String
    var latestPrice: Double
    var changePercent: Double
}
