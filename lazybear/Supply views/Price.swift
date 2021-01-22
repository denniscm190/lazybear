//
//  Price.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 22/1/21.
//

import SwiftUI
import SwiftUICharts

struct Price: View {
    var body: some View {
        VStack {
            Divider()
            HStack {
                Text("320.30")
                    .font(.headline)
                    .padding(.trailing)
                
                Text("+1.67%")
                    .foregroundColor(.green)
                
                Spacer()
                AddWatchlist()
            }
            .padding([.leading, .trailing])
            Divider()
            
            DateSelection()
            
            let gradient = GradientColor(start: .green, end: .green)
            let style = ChartStyle(
                backgroundColor: .white,
                accentColor: .green,
                gradientColor: gradient,
                textColor: .black,
                legendTextColor: .black,
                dropShadowColor: .white)
            
            LineView(data: [8,23,54,32,12,37,7,23,43], title: "", style: style)
                .padding([.leading, .trailing])
                .offset(y: -40)
        }
    }
}

struct Price_Previews: PreviewProvider {
    static var previews: some View {
        Price()
    }
}
