//
//  SummaryInsiderModel.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 23/5/21.
//

import SwiftUI

struct SummaryInsiderModel: Codable {
    var date: Int
    var fullName: String
    var netTransacted: Int
    var reportedTitle: String
    var totalBought: Int
    var totalSold: Int
    var updated: Int
}
