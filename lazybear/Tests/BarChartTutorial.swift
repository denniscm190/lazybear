//
//  BarChartTutorial.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 31/1/21.
//

import SwiftUI

struct DataPoint2: Identifiable {
    let id: Int
    let values: Double
    let color: Color
    let title: String
    
    init(value: Double, color: Color, title: String = "") {
        self.id = Int.random(in: 1..<Int.max)
        self.values = value
        self.color = color
        self.title = title
    }
    
    init(id: Int, value: Double, color: Color, title: String = "") {
        self.id = Int.random(in: 1..<Int.max)
        self.values = value
        self.color = color
        self.title = title
    }
}

struct BarChartTutorial: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct BarChartTutorial_Previews: PreviewProvider {
    static var previews: some View {
        BarChartTutorial()
    }
}
