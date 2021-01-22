//
//  LatestPrice.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 22/1/21.
//

import SwiftUI

class LatestPrice: ObservableObject {
    @Published var result = [LatestPriceModel]()
    @Published var showingView = false
    @Published var showingAlert = false
    
    func request(symbol: String, sandbox: Bool) {
        guard let url = URL(string: latestPriceUrl(symbol: symbol, sandbox: sandbox)) else {  // Change sandbox when production
            print("Invalid URL")
            return
        }
        print(url)
        let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                if let decodedResponse = try? JSONDecoder().decode([LatestPriceModel].self, from: data) {
                    // we have good data – go back to the main thread
                    DispatchQueue.main.async {
                        // update our UI
                        self.result = decodedResponse
                        print("API request ok")
                        
                        // Check if data is empty
                        if self.result.isEmpty || self.result.count <= 1 {
                            print("Data is empty")
                            self.showingView = false
                            self.showingAlert = true
                        } else {
                            print("Showing view...")
                            self.showingView = true
                        }
                        
                    }

                    // everything is good, so we can exit
                    return
                }
            }

            // if we're still here it means there was a problem
            print("Fetch failed: \(error?.localizedDescription ?? "Unknown error")")
        }.resume()
    }
}
