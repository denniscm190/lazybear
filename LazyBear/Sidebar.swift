//
//  Sidebar.swift
//  lazybear
//
//  Created by Dennis Concepción Martín on 17/07/2021.
//

import SwiftUI

struct Sidebar: View {
    var body: some View {
        List {
            NavigationLink(destination: Watchlist()) {
                Label("Watchlist", systemImage: "list.star")
            }
            NavigationLink(destination: Search()) {
                Label("Search", systemImage: "magnifyingglass")
            }
        }
        .navigationTitle("Categories")
        .listStyle(SidebarListStyle())
    }
}

struct Sidebar_Previews: PreviewProvider {
    static var previews: some View {
        Sidebar()
    }
}
