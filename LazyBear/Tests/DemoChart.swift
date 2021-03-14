//
//  DemoChart.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 13/3/21.
//

import SwiftUI

struct DemoChart: View {
    let sampleData: [Double] = [10, 11.2, 13.4, 10.2, 13.4, 12.4, 15.6, 18.7, 20.9, 21.2, 10.3]

    var body: some View {
        let normalizedData = normalize(sampleData)
        Path { path in
            path.move(to: CGPoint(x: 0, y: 0))
            for point in normalizedData {
                path.addLine(to: CGPoint(x: 1, y: point))
            }
            
        }
        .fill(Color.green)
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

struct DemoChart_Previews: PreviewProvider {
    static var previews: some View {
        DemoChart()
    }
}
