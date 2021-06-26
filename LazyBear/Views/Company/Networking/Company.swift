//
//  Company.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 20/6/21.
//

import SwiftUI
import Alamofire

class Company: ObservableObject {
    @Published var showView = false
    @Published var showChart = true  /// To show a ProgressView when the chart is refreshed (Date range selected)
    @Published var data = CompanyResponse()
    
    func request(_ url: String, _ requestType: RequestType) {
        if requestType == .refresh { self.showChart = false }
        AF.request(url).responseDecodable(of: CompanyResponse.self) { response in
            if let value = response.value {
                switch requestType {
                case .initial:
                    self.data = value
                case .streaming:
                    self.data.quote = value.quote
                case .refresh:
                    self.data.historicalPrices = value.historicalPrices
                }
                
                self.showView = true
                self.showChart = true
            }
        }
    }
}
