//
//  CurrencyModel.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 21/4/21.
//

import SwiftUI


struct CurrencyModel: Codable, Hashable {
    var symbol: String
    var name: String
    var flag: String
    var rate: Double
}
