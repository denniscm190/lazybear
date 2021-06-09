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
        if style.orientation == .VStack {
            VStack(alignment: style.horizontalAlignment) {
                Price(latestPrice: latestPrice, changePercent: changePercent, style: style)
            }
        } else {
            HStack(alignment: style.verticalAlignment) {
                Price(latestPrice: latestPrice, changePercent: changePercent, style: style)
            }
            .if(style.showBackground) { content in
                content
                    .padding(10)
                    .background(
                        RoundedRectangle(cornerRadius: 15)
                            .foregroundColor(Color(.tertiarySystemBackground))
                    )
            }
        }
    }
}

/*
 Apply modifiers to the passed view on some condition
 */
extension View {
   @ViewBuilder
   func `if`<Content: View>(_ conditional: Bool, content: (Self) -> Content) -> some View {
        if conditional {
            content(self)
        } else {
            self
        }
    }
}

struct Price: View {
    var latestPrice: Double
    var changePercent: Double
    var style: PriceViewStyle
    
    var body: some View {
        Text("\(latestPrice, specifier: "%.2f")")
            .foregroundColor(changePercent < 0 ? .red: .green)
            .font(style.priceFont)
            .fontWeight(style.priceFontWeight)
        
        Text("\(changePercent*100, specifier: "%.2f")%")
            .foregroundColor(changePercent < 0 ? .red: .green)
            .font(style.percentFont)
            .fontWeight(style.percentFontWeight)
    }
}


struct PriceView_Previews: PreviewProvider {
    static var previews: some View {
        PriceView(
            latestPrice: 120.30,
            changePercent: 0.03,
            style: PriceViewStyle(
                horizontalAlignment: .leading,
                verticalAlignment: .center,
                orientation: .VStack,
                priceFont: .body,
                priceFontWeight: .semibold,
                percentFont: .callout,
                percentFontWeight: .semibold,
                showBackground: true
            )
        )
    }
}
