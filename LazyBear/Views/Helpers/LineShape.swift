//
//  LineShape.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 29/3/21.
//

import SwiftUI

struct LineShape: Shape {
    var width: CGFloat
    var height: CGFloat
    var normalizedData: [Double]
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        let spaceBetweenPoints = Double(width) / Double(normalizedData.count - 1)
        var xPoint: Double = 0
        let initialYPoint = normalizedData.first ?? 0 * Double(height)
        
        path.move(to: CGPoint(x: xPoint, y: initialYPoint))
        
        var firstLoop = true
        for yPoint in normalizedData {
            if firstLoop {
                firstLoop = false
            } else {
                xPoint += spaceBetweenPoints
                let yPoint = yPoint * Double(height)
                path.addLine(to: CGPoint(x: xPoint, y: yPoint))
            }
        }
        
        return path
    }
}

