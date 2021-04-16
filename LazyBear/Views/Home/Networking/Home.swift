//
//  Home.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 11/4/21.
//

import SwiftUI

class Home: ObservableObject {
    @Published var showView = false
    @Published var data = HomeResponse()
    
    var streamingRequests = 0  // Count streaming requests
    
    func request(_ url: String) {
        genericRequest(url: url, model: HomeResponse.self) { response in
            self.streamingRequests += 1
            
            // If is the first request -> init()
            if self.streamingRequests == 1 {
                self.data = response
            } else {
                // If not, request streaming data (without intradayPrices and latestCurrencies)
                self.data.lists = response.lists
                self.data.sectorPerformance = response.sectorPerformance
            }
            self.showView = true
        }
    }
}
