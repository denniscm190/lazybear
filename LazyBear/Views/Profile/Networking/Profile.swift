//
//  Profile.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 7/5/21.
//

import SwiftUI

class Profile: ObservableObject {
    @Published var showView = false
    @Published var data = ProfileResponse()
    
    func request(_ url: String, isInitRequest: Bool) {
        genericRequest(url: url, model: ProfileResponse.self) { response in

            // If is the first request -> init()
            if isInitRequest {
                self.data = response
            } else {
                 // If not, request streaming data (without intradayPrices)
                self.data.quotes = response.quotes
            }

            self.showView = true
        }
    }
}
