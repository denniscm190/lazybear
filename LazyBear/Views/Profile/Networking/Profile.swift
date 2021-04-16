//
//  Profile.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 16/4/21.
//

import SwiftUI

class Profile: ObservableObject {
    @Published var showView = false
    @Published var data = ProfileResponse()
    
    var streamingRequests = 0  // Count streaming requests
    
    func request(_ url: String) {
        genericRequest(url: url, model: ProfileResponse.self) { response in
            print(response)
            self.streamingRequests += 1
            
            // If is the first request -> init()
            if self.streamingRequests == 1 {
                self.data = response
            } else {
                // If not, request streaming data (without intradayPrices)
                self.data.quotes = response.quotes
            }
        }
    }
}
