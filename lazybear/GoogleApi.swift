//
//  GoogleApi.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 24/1/21.
//

import SwiftUI

struct GoogleApi {
    enum URL {
        case company(symbol: String)
        
        var path: String {
            switch self {
            case let .company(symbol):
                return "https://storage.googleapis.com/iex/api/logos/\(symbol).png"
            }
        }
    }
}
