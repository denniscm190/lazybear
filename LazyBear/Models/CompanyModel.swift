//
//  LocalCompany.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 19/2/21.
//

import SwiftUI

struct CompanyModel: Hashable, Codable {
    var symbol: String
    var exchange: String
    var exchangeName: String
    var name: String
    var region: String
    var currency: String
}

