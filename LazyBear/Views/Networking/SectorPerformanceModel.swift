//
//  SectorPerformanceModel.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 30/3/21.
//

import SwiftUI

struct SectorPerformanceModel: Codable, Hashable {
    var name: String
    var performance: Double
    var lastUpdated: Int
}
