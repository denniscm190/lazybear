//
//  PriceView.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 3/4/21.
//

import SwiftUI

struct PriceView: View {
    var latestPrice: Double
    var changePercent: Double
    
    var body: some View {
        VStack {
            Text("$\(latestPrice, specifier: "%.2f")")
                .foregroundColor(changePercent < 0 ? .red: .green)
                .fontWeight(.semibold)
                .padding(.top)
            
            Text("\(changePercent*100, specifier: "%.2f")%")
                .foregroundColor(changePercent < 0 ? .red: .green)
                .fontWeight(.semibold)
        }
    }
}


struct PriceView_Previews: PreviewProvider {
    static var previews: some View {
        PriceView(latestPrice: 120.30, changePercent: 0.03)
    }
}
