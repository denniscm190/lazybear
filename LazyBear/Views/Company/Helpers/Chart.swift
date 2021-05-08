//
//  Chart.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 8/5/21.
//

import SwiftUI
import StockCharts

struct Chart: View {
    var body: some View {
        let priceViewStyle = PriceViewStyle(
            alignment: .leading,
            priceFont: .title2,
            priceFontWeight: .semibold,
            percentFont: .title3,
            percentFontWeight: .semibold
        )
        
        RoundedRectangle(cornerRadius: 15)
            .foregroundColor(Color(.secondarySystemBackground))
            .frame(height: 300)
            .overlay(
                VStack {
                    HStack {
                        PriceView(latestPrice: 120.30, changePercent: 0.03, style: priceViewStyle)
                        Spacer()
                    }
                    .padding([.top, .leading, .trailing])
                    
                    LineChartView(data: [120.3, 120.4, 121.0, 122.0],
                                  dates: nil,
                                  hours: nil,
                                  dragGesture: true)
                        .padding(.bottom)
                }
            )
    }
}

struct Chart_Previews: PreviewProvider {
    static var previews: some View {
        Chart()
    }
}
