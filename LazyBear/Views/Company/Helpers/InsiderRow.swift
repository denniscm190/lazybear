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
    var insiderRoster: InsiderRosterModel
    
    var body: some View {
        RowShape()
            .frame(height: 105)
            .overlay(
                VStack(alignment: .leading) {
                    Text(insiderRoster.entityName.capitalized)
                        .lineLimit(1)
                        .font(.headline)
                    
                    Text("Last updated: \(convertEpoch(insiderRoster.reportDate, false))")
                        .opacity(0.5)
                        .font(.subheadline)
                    
                    HStack {
                        Spacer()
                        Text("\(insiderRoster.position) shares owned")
                            .font(.caption)
                            .opacity(0.5)
                    }

                    CapsuleChartView(percentageOfWidth: percentageOfWidth)
                }
                .padding()
                ,alignment: .leading
            )
    }
}

struct InsiderRow_Previews: PreviewProvider {
    static var previews: some View {
        InsiderRow(
            percentageOfWidth: 0.6,
            insiderRoster:
                InsiderRosterModel(
                    entityName: "Dennis Concepcion",
                    position: 1230,
                    reportDate: 1234567
                )
        )
    }
}
