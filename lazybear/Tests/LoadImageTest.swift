//
//  LoadImageTest.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 24/1/21.
//

import SwiftUI
import SDWebImageSwiftUI

struct LoadImageTest: View {
    var body: some View {
        let url = LogoApi.URL.company(symbol: "AMZN").path
        WebImage(url: URL(string: url))
            .indicator(.activity) // Activity Indicator
    }
}

