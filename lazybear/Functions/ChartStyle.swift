//
//  ChartStyle.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 23/1/21.
//

import SwiftUI
import SwiftUICharts

func chartStyle() -> ChartStyle {
    let gradient = GradientColor(start: .green, end: .green)
    let style = ChartStyle(
        backgroundColor: .white,
        accentColor: .green,
        gradientColor: gradient,
        textColor: .black,
        legendTextColor: .black,
        dropShadowColor: .white)
    
    return style
}
