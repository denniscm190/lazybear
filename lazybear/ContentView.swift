//
//  ContentView.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 27/09/2020.
//

import SwiftUI

struct ContentView: View {

    var body: some View {
        TabView {
            // First view
            Watchlist()
                .tabItem {
                    Label("Menu", systemImage: "list.dash")
                }
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
