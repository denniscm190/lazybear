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
            VStack {
                ZStack {
                    Grid(height: deviceSize.width, width: deviceSize.width)
                        .clipped()
                        .background(LinePath(width: deviceSize.width, data: data))
                    
                        
                }
            }
            .frame(width: deviceSize.width, height: deviceSize.width / 2)
        
    }
}

struct LineChart_Previews: PreviewProvider {
    static var previews: some View {
        LineChart(data: [50.0, 50.5, 51.0, 50.4, 50.8, 51.3, 51.5, 52, 51.9, 52.4])
            .environmentObject(DeviceSize())
    }
}

struct Grid: View {
    var height: CGFloat
    var width: CGFloat
    
    var body: some View {
        VStack {
            Rectangle()
                .stroke(Color.gray.opacity(0.2), lineWidth: 0.5)
            
            Group {
                Rectangle()
                    .stroke(Color.gray.opacity(0.2), lineWidth: 0.5)
                
                Rectangle()
                    .stroke(Color.gray.opacity(0.2), lineWidth: 0.5)
            }
            .offset(y: -8)
            .padding(.bottom, -8)
        }
    }
}
