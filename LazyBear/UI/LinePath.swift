//
//  LinePath.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 15/3/21.
//

import SwiftUI

struct LinePath: View {
    var width: CGFloat
    var data: [Double]

    var body: some View {
        let height = width/2
        if !data.isEmpty {
            let normalizedData = normalize(data)
                
            // Substract 2 to skip the first and the last item
            let widthBetweenPoints = Double(width) / Double(normalizedData.count - 2)
            
            Path { path in
                let initialPoint = normalizedData[0] * Double(height)
                var x: Double = 0
                path.move(to: CGPoint(x: x, y: initialPoint))
                
                for y in normalizedData {
                    // Skip first item
                    if normalizedData.firstIndex(of: y) != 0 {
                        x += widthBetweenPoints
                        let y = y * Double(height)
                        path.addLine(to: CGPoint(x: x, y: y))
                    }
                }
            }
            .stroke(Color.green, lineWidth: 2)
            .rotationEffect(.degrees(180), anchor: .center)  // The path must be rotated
            .rotation3DEffect(.degrees(180), axis: (x: 0.0, y: 1.0, z: 0.0))
            
        }
    }
    
    func normalize(_ data: [Double]) -> [Double] {
        var normalData = [Double]()
        let min = data.min()!
        let max = data.max()!

        for value in data {
            let normal = (value - min) / (max - min)
            normalData.append(normal)
        }

        return normalData
    }
    
}

struct LinePath_Previews: PreviewProvider {
    static var previews: some View {
        GeometryReader { geo in
            VStack {
                let data: [Double] = [50.0, 50.5, 51.0, 50.4, 50.8, 51.3, 51.5, 52, 51.9, 52.4]
                LinePath(width: geo.size.width, data: data)
            }
        }
    }
}
