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
    
    func request(_ url: String, isInitRequest: Bool, _ view: String) {
        if view == "chart" {
            genericRequest(url: url, model: ChartResponse.self) { response in
                if isInitRequest { self.chartData = response }  // If is the first request -> init()
                else { self.chartData.quote = response.quote }  // If not, request streaming data (without intradayPrices)
                self.showChartView = true
            }
        }
    }
}
