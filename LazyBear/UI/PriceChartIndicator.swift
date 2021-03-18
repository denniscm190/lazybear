//
//  PriceChartIndicator.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 18/3/21.
//

import SwiftUI

struct PriceChartIndicator: View {
    var prices: [Double]
    var dates: [String]
    @Binding var indexValue: Int
    
    var body: some View {
        HStack {
            Group {
                Text(dates[indexValue])
                Text("\(prices[indexValue], specifier: "%.2f")")
                    .foregroundColor(.blue)
            }
            .font(.subheadline)
        }
    }
}

struct PriceChartIndicator_Previews: PreviewProvider {
    static var previews: some View {
        PriceChartIndicator(prices: [100, 50], dates: ["10-10-2020", "11-10-2020"], indexValue: .constant(0))
    }
}
