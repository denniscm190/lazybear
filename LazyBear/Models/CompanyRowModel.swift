//
//  CompanyRowModel.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 28/3/21.
//

import SwiftUI

struct CompanyRowModel: Codable, Hashable {
    var symbol: String
    var companyName: String
    var latestPrice: Double
    var changePercent: Double
}
