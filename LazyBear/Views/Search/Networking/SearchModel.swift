//
//  SearchModel.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 3/4/21.
//

import SwiftUI

struct SearchModel: Codable, Hashable {
    var securityName: String
    var symbol: String
    var region: String
    var currency: String
}
