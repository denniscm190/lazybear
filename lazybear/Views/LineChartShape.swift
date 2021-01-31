//
//  LineChartShape.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 31/1/21.
//

import SwiftUI

struct DataPoint {
    let value: Double
}

struct LineChartShape: Shape {
    let dataPoints: [DataPoint]
    let pointSize: CGFloat
    let maxValue: Double
    let drawingLines: Bool
    
    init(dataPoints: [DataPoint], pointSize: CGFloat, drawingLines: Bool) {
        self.dataPoints = dataPoints
        self.pointSize = pointSize
        self.drawingLines = drawingLines
        
        let highestPoint = dataPoints.max { $0.value < $1.value }
        maxValue = highestPoint?.value ?? 1
    }
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let drawRect = rect.insetBy(dx: pointSize, dy: pointSize)
        
        let xMultiplier = drawRect.width / CGFloat(dataPoints.count - 1)
        let yMultiplier = drawRect.height / CGFloat(maxValue)
        
        for(index, dataPoint) in dataPoints.enumerated() {
            var x = xMultiplier * CGFloat(index)
            var y = yMultiplier * CGFloat(dataPoint.value)
            
            y = drawRect.height - y
            
            x += drawRect.minX
            y += drawRect.minY
            
            if drawingLines {
                if index == 0 {
                    path.move(to: CGPoint(x: x, y: y))
                } else {
                    path.addLine(to: CGPoint(x: x, y: y))
                }
            } else {
                x -= pointSize / 2
                y -= pointSize / 2
                
                path.addEllipse(in: CGRect(x: x, y: y, width: pointSize, height: pointSize))
            }
        }
        
        return path
    }
}
