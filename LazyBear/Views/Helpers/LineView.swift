//
//  LineView.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 29/3/21.
//

import SwiftUI

struct LineView: View {
    var body: some View {
        GeometryReader { proxy in
            VStack {
                let sampleData = generateRandomSample()
                LineShape(width: proxy.size.width, height: proxy.size.height, normalizedData: normalize(sampleData))
                    .stroke(lineWidth: 2)
                    .rotationEffect(.degrees(180), anchor: .center)
                    .rotation3DEffect(.degrees(180), axis: (x: 0.0, y: 1.0, z: 0.0))
            }
        }
    }
    
    // Normalize data
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
    
    // DELETE THIS FUNCTION ON PRODUCTION
    private func generateRandomSample() -> [Double] {
        var randomSample = [Double]()
        for _ in 1..<10 {
            randomSample.append(Double.random(in: 1...100))
        }
        
        return randomSample
    }
}

struct LineView_Previews: PreviewProvider {
    static var previews: some View {
        LineView()
    }
}
