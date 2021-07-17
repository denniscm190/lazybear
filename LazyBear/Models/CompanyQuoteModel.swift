//
//  CompanyQuoteModel.swift
//  lazybear
//
//  Created by Dennis Concepción Martín on 17/07/2021.
//

import SwiftUI

struct CompanyQuoteModel: Codable {
    var symbol: String?
    var companyName: String?
    var latestPrice: Float?
    var changePercent: Float?
    var change: Float?
}
