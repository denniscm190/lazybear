//
//  SearchResponse.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 16/4/21.
//

import SwiftUI

struct SearchResponse: Codable, Hashable {
    var currency: String?
    var exchange: String?
    var region: String?
    var securityName: String?
    var symbol: String?
}
