//
//  InsiderRosterRow.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 21/6/21.
//

import SwiftUI
import StockCharts

struct InsiderRosterRow: View {
    var insider: InsiderRosterModel
    var percentageOfWidth: CGFloat
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(insider.entityName.capitalized)
                .lineLimit(1)
                .font(.headline)
            
            Text("Last updated: \(convertEpoch(insider.reportDate, false))")
                .opacity(0.5)
                .font(.subheadline)
            
            HStack {
                Spacer()
                Text("\(insider.position ?? 0) shares owned")
                    .font(.caption)
                    .opacity(0.5)
            }
            
            CapsuleChartView(percentageOfWidth: percentageOfWidth)
        }
    }
}

struct InsiderRosterRow_Previews: PreviewProvider {
    static var previews: some View {
        InsiderRosterRow(
            insider:
                InsiderRosterModel(
                    entityName: "Tim Cook",
                    position: 12345,
                    reportDate: 12345
                ),
            percentageOfWidth: 0.6
        )
    }
}
