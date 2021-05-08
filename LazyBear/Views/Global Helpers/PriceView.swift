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
    var style: PriceViewStyle
    
    var body: some View {
        VStack(alignment: style.alignment) {
            Text("$\(latestPrice, specifier: "%.2f")")
                .foregroundColor(changePercent < 0 ? .red: .green)
                .font(style.priceFont)
                .fontWeight(style.priceFontWeight)
            
            Text("\(changePercent*100, specifier: "%.2f")%")
                .foregroundColor(changePercent < 0 ? .red: .green)
                .font(style.percentFont)
                .fontWeight(style.percentFontWeight)
        }
    }
}


struct PriceView_Previews: PreviewProvider {
    static var previews: some View {
        PriceView(
            latestPrice: 120.30,
            changePercent: 0.03,
            style: PriceViewStyle(
                alignment: .leading,
                priceFont: .body,
                priceFontWeight: .semibold,
                percentFont: .callout,
                percentFontWeight: .semibold
            )
        )
    }
}
