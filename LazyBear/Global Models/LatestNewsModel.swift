//
//  LatestNewsModel.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 15/5/21.
//

import SwiftUI

struct LatestNewsModel: Codable, Hashable {
    var datetime: Int64
    var headline: String
    var image: String
    var source: String
    var summary: String
    var url: String
}
