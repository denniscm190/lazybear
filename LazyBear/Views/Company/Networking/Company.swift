//
//  Company.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 15/5/21.
//

import SwiftUI
import Bazooka

class Company: ObservableObject {
    @Published var showChartView = false
    @Published var chartData = ChartResponse()
    
    @Published var showInsidersView = false
    @Published var insidersData = InsidersResponse()
    
    func request(_ url: String, _ requestType: RequestType, _ view: String) {
        let bazooka = Bazooka()
        if view == "chart" {
            bazooka.request(url: url, model: ChartResponse.self) { response in
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
        } else if view == "insider" {
            bazooka.request(url: url, model: InsidersResponse.self) { response in
                self.insidersData = response
                
                self.showInsidersView = true
            }
        }
    }
}
