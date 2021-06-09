//
//  PriceViewStyle.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 8/5/21.
//

import SwiftUI

class PriceViewStyle {
    var horizontalAlignment: HorizontalAlignment
    var verticalAlignment: VerticalAlignment
    var orientation: Orientation
    var priceFont: Font
    var priceFontWeight: Font.Weight
    var percentFont: Font
    var percentFontWeight: Font.Weight
    var showBackground: Bool
    
    init(horizontalAlignment: HorizontalAlignment, verticalAlignment: VerticalAlignment, orientation: Orientation, priceFont: Font, priceFontWeight: Font.Weight, percentFont: Font, percentFontWeight: Font.Weight, showBackground: Bool) {
        self.horizontalAlignment = horizontalAlignment
        self.verticalAlignment = verticalAlignment
        self.orientation = orientation
        self.priceFont = priceFont
        self.priceFontWeight = priceFontWeight
        self.percentFont = percentFont
        self.percentFontWeight = percentFontWeight
        self.showBackground = showBackground
    }
}

enum Orientation {
    case HStack, VStack
}
