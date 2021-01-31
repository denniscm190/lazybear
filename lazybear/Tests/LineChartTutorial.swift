//
//  LineChartTutorial.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 31/1/21.
//

import SwiftUI

struct LineChartTutorial: View {
    @State private var data = makeDataPoints()
    
    var body: some View {
        LineChart(dataPoints: data, lineColor: .blue, lineWidth: 5, pointColor: .red, pointSize: 10)
            .frame(width: 300, height: 200)
            .onTapGesture {
                data = Self.makeDataPoints()
            }
    }
    
    // Generate random data usefull for representation
    static func makeDataPoints() -> [DataPoint] {
        var isGoingUp = true
        var currentValue = 50.0
        
        return (1...50).map { _ in
            if isGoingUp {
                currentValue += Double.random(in: 1...10)
            } else {
                currentValue -= Double.random(in: 1...10)
            }
            
            if isGoingUp {
                if Int.random(in: 0..<10) == 0 {
                    isGoingUp.toggle()
                }
            } else {
                if Int.random(in: 0..<7) == 0 {
                    isGoingUp.toggle()
                }
            }
            
            return DataPoint(value: abs(currentValue))
        }
    }
}

struct LineChartTutorial_Previews: PreviewProvider {
    static var previews: some View {
        LineChartTutorial()
    }
}
