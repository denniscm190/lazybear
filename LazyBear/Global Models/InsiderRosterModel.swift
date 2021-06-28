//
//  InsiderRosterModel.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 23/5/21.
//

import SwiftUI

struct InsiderRosterModel: Codable, Hashable {
    var entityName: String
    var position: Float?
    var reportDate: Int64
}
