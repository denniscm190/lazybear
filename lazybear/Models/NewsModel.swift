//
//  NewsModel.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 4/2/21.
//

import SwiftUI

struct NewsModel: Codable, Hashable {
    var datetime: Int?
    var headline: String?
    var source: String?
    var url: String?
    var summary: String?
    var image: String?
}
