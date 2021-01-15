//
//  PriceOverview.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 15/1/21.
//

import SwiftUI

struct PriceOverview: View {
    @State var historicalPrices: HistoricalPrices
    
    var body: some View {
        VStack {
            HStack {
                Text("$ " + String(historicalPrices.result.last!.close))
                    .font(.title)
                    .fontWeight(.bold)
                
                let pct = historicalPrices.result.last!.changePercent * 100
                Text(String(format: "%.2f", pct) + " %")
                    .font(.headline)
                    .foregroundColor(whichColor())
                
                Spacer()
            }
            .padding([.leading, .top, .trailing])
                
            HStack {
                Text(String(historicalPrices.result.last!.date) + " last price")
                    .font(.caption)
                    .padding([.leading])
                    .opacity(0.5)
                
                Spacer()
            }
        }
    }
    
    func whichColor() -> Color {
        if historicalPrices.result.last!.changePercent < 0 {
            return Color(.red)
        }
        else {
            return Color(.green)
        }
    }
}

struct PriceOverview_Previews: PreviewProvider {
    static var previews: some View {
        PriceOverview(historicalPrices: HistoricalPrices.init())
    }
}
