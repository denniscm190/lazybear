//
//  CompanyData.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 31/12/20.
//

import Foundation

struct CompanyModel: Hashable, Codable {
    var symbol: String
    var exchange: String
    var exchangeSuffix: String
    var exchangeName: String
    var name: String
    var region: String
    var currency: String
}

