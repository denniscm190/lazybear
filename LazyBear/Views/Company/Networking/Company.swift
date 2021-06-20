//
//  Company.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 20/6/21.
//

import SwiftUI
import Bazooka

class Company: ObservableObject {
    @Published var showView = false
    @Published var showChart = true  /// To show a ProgressView when the chart is refreshed (Date range selected)
    @Published var data = CompanyResponse()
    
    func request(_ url: String, _ requestType: RequestType) {
        if requestType == .refresh { self.showChart = false }
        let bazooka = Bazooka()
        bazooka.request(url: url, model: CompanyResponse.self) { response in
            switch requestType {
            case .initial:
                self.data = response
            case .streaming:
                self.data.quote = response.quote
            case .refresh:
                self.data.historicalPrices = response.historicalPrices
            }
            
            self.showView = true
            self.showChart = true
        }
    }
}
