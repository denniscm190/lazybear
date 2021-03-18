//
//  IndicatorPoint.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 17/3/21.
//

import SwiftUI

struct IndicatorPoint: View {
    var body: some View {
        Circle()
            .frame(width: 20, height: 20)
            .foregroundColor(.blue)
    }
}

struct IndicatorPoint_Previews: PreviewProvider {
    static var previews: some View {
        IndicatorPoint()
    }
}
