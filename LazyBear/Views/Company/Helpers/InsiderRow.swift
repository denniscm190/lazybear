//
//  InsiderRow.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 5/6/21.
//

import SwiftUI
import StockCharts

struct InsiderRow: View {
    var percentageOfWidth: CGFloat
    
    var body: some View {
        RowShape()
            .frame(height: 120)
            .overlay(
                VStack(alignment: .leading) {
                    Text("Dennis Concepcion")
                        .font(.title3)
                        .fontWeight(.semibold)

                    Text("Random guy")
                    CapsuleChartView(percentageOfWidth: percentageOfWidth)
                        .padding(.top)
                }
                .padding()
                ,alignment: .leading
            )
    }
}

struct InsiderRow_Previews: PreviewProvider {
    static var previews: some View {
        InsiderRow(percentageOfWidth: 0.6)
    }
}
