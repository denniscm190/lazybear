//
//  RandomColor.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 22/1/21.
//

import SwiftUI

func randomColor(index: Int) -> Color {
    let systemColour: [Color] = [Color(.systemBlue), Color(.systemRed), Color(.systemPink), Color(.systemTeal), Color(.systemGreen), Color(.systemOrange), Color(.systemYellow), Color(.systemPurple), Color(.systemIndigo), Color(.systemGray)]
    
    var index = index
    if index > 10 { index = index/10 }
    if index > 100 { index = index/100 }
    if index > 1000 { index = index/1000 }
    if index > 10000 { index = index/10000 }
    
    let color = systemColour[index]
    
    return color
}
