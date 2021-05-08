//
//  PriceViewStyle.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 8/5/21.
//

import SwiftUI

class PriceViewStyle {
    var alignment: HorizontalAlignment
    var priceFont: Font
    var priceFontWeight: Font.Weight
    var percentFont: Font
    var percentFontWeight: Font.Weight
    
    init(alignment: HorizontalAlignment, priceFont: Font, priceFontWeight: Font.Weight, percentFont: Font, percentFontWeight: Font.Weight) {
        self.alignment = alignment
        self.priceFont = priceFont
        self.priceFontWeight = priceFontWeight
        self.percentFont = percentFont
        self.percentFontWeight = percentFontWeight
    }
}
