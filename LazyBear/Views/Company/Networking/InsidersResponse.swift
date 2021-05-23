//
//  InsidersResponse.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 23/5/21.
//

import SwiftUI

struct InsidersResponse: Codable {
    var insiderSummary: [SummaryInsiderModel]?
    
    private enum CodingKeys: String, CodingKey {
        case insiderSummary = "insider_summary"
    }
}
