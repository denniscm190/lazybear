//
//  LineChart.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 15/3/21.
//

import SwiftUI

struct LineChart: View {
    var data: [Double]
    @EnvironmentObject var deviceSize: DeviceSize
    
    var body: some View {
        if !data.isEmpty {
            let normalizedData = normalize(data)
            
            VStack {
                LineView(width: deviceSize.width, height: deviceSize.width / 3, normalizedData: normalizedData)
                    .rotationEffect(.degrees(180), anchor: .center) 
                    .rotation3DEffect(.degrees(180), axis: (x: 0.0, y: 1.0, z: 0.0))
                    
            }
            .frame(width: deviceSize.width, height: deviceSize.width / 3)
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

struct LineChart_Previews: PreviewProvider {
    static var previews: some View {
        LineChart(data: [50.0, 50.5, 51.0, 50.4, 50.8, 51.3, 51.5, 52, 51.9, 52.4])
            .environmentObject(DeviceSize())
    }
}
