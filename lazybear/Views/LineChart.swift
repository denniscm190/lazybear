//
//  LineChart.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 31/1/21.
//

import SwiftUI

struct LineChart: View {
    let dataPoints: [DataPoint]
    var lineColor = Color.primary
    var lineWidth: CGFloat = 2
    
    var pointColor = Color.primary
    var pointSize: CGFloat = 5
    
    var body: some View {
        ZStack {
            if lineColor != .clear {
                LineChartShape(dataPoints: dataPoints, pointSize: pointSize, drawingLines: true)
                    .stroke(lineColor, lineWidth: lineWidth)
            }
            
            /*
            if lineColor != .clear {
                LineChartShape(dataPoints: dataPoints, pointSize: pointSize, drawingLines: false)
                    .fill(pointColor)
            }
             */
        }
    }
}
