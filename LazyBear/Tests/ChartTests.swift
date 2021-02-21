//
//  ChartTests.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 20/2/21.
//

import SwiftUI
import Charts

struct ChartTests: View {
    var body: some View {
        let someData: [Double] = [50.0, 49.1, 1.4, 120.4, 523.30]
        Chart(data: normalize(someData))
            .chartStyle(
                AreaChartStyle(.quadCurve, fill:
                    LinearGradient(gradient: .init(colors: [Color.blue.opacity(0.2), Color.blue.opacity(0.05)]), startPoint: .top, endPoint: .bottom)
                )
            )
    }
}

struct ChartTests_Previews: PreviewProvider {
    static var previews: some View {
        ChartTests()
    }
}
