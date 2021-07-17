//
//  ContentViewPad.swift
//  lazybear
//
//  Created by Dennis Concepción Martín on 17/07/2021.
//

import SwiftUI

struct ContentViewPad: View {
    var body: some View {
        NavigationView {
            Sidebar()
            Watchlist()
            CompanyView(symbol: "AAPL")
        }
    }
}

struct ContentViewPad_Previews: PreviewProvider {
    static var previews: some View {
        ContentViewPad()
    }
}
