//
//  HomeResponse.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 11/4/21.
//

import SwiftUI

struct HomeResponse: Codable {
    var latestCurrencies: [CurrencyModel]?
    var lists: [String: [CompanyModel]]?  /// String = list name
    var sectorPerformance: [SectorPerformanceModel]?
    var tradingDates: [String]?
}
