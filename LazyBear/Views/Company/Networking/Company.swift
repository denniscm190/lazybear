//
//  Company.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 15/5/21.
//

import SwiftUI

class Company: ObservableObject {
    @Published var showChartView = false
    @Published var chartData = ChartResponse()
    
    func request(_ url: String, _ requestType: RequestType, _ view: String) {
        if view == "chart" {
            genericRequest(url: url, model: ChartResponse.self) { response in
                switch requestType {
                case .initial:
                    self.chartData = response
                case .refresh:
                    self.chartData.historicalPrices = response.historicalPrices
                case .streaming:
                    self.chartData.quote = response.quote
                }
                
                self.showChartView = true
            }
        }
    }
}
