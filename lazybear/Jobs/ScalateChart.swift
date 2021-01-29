//
//  ScalateChart.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 23/1/21.
//

import SwiftUI

func scalateChart(prices: [Double], selectedPeriod: Int) -> [Double] {
    // Remove every two items to shorter the chart data points
    var indexesToRemove = Set<Int>()

    if selectedPeriod >= 4 {
        for index in 0..<prices.count {
            indexesToRemove.insert(index*2)
        }
    }
    let prices = prices
        .enumerated()
        .filter { !indexesToRemove.contains($0.offset) }
        .map { $0.element }
    
    return prices
}
