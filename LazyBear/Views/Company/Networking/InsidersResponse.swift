//
//  InsidersResponse.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 23/5/21.
//

import SwiftUI

struct InsidersResponse: Codable {
    var insiderRoster: [InsiderRosterModel]?
    
    private enum CodingKeys: String, CodingKey {
        case insiderRoster = "insider_roster"
    }
}
