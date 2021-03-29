//
//  HomeView.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 28/3/21.
//

import SwiftUI

struct HomeView: View {
    
    var body: some View {
        NavigationView {
            List {
                SectorRow()
                    .listRowInsets(EdgeInsets())
                
                let keyTitles = ["Top gainers", "Top losers", "Most active"]
                ForEach(keyTitles, id: \.self) { keyTitle in
                    TopStockRow(keyTitle: keyTitle)
                    
                }
                .listRowInsets(EdgeInsets())
            }
            .navigationTitle("Home")
            .navigationBarTitleDisplayMode(.inline)
            .navigationViewStyle(StackNavigationViewStyle())
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
