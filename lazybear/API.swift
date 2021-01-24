//
//  API.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 24/1/21.
//

import SwiftUI


enum Url {
    case sandbox
    case production
    
    var url: String {
        switch self {
        case .sandbox:
            return "https://sandbox.iexapis.com"
        case .production:
            return "https://cloud.iexapis.com"
        }
    }
}

enum Endpoints {
    case historicalPrices(H)
    enum H {
        case range(R)
        enum R {
            
        }
    }
}

struct SomeTest: View {
    var body: some View {
        Text("Hello world")
            .onAppear {
                
            }
    }
}
