//
//  HomeView.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 28/3/21.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject var homeData = HomeData()
    @State private var showTradingDates = false
    
    static let taskDateFormat: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter
        }()

        let dueDate = Date()
    
    var body: some View {
        NavigationView {
            List {
                SectorRow(sectorPerformance: homeData.sectorPerformance)
                    .listRowInsets(EdgeInsets())
                
                let keyTitles = ["Top gainers", "Top losers", "Most active"]
                ForEach(keyTitles, id: \.self) { keyTitle in
                    TopStockRow(keyTitle: keyTitle)
                    
                }
                .listRowInsets(EdgeInsets())
            }
            .navigationTitle("\(dueDate, formatter: Self.taskDateFormat)")
            .navigationBarTitleDisplayMode(.inline)
            .navigationViewStyle(StackNavigationViewStyle())
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: { showTradingDates = true }) {
                        Image(systemName: "calendar.badge.clock")
                    }
                }
                
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: { homeData.getSectorPerformance() }) {
                        Text("Test recall")
                    }
                }
            }
        }
        .onAppear { homeData.getSectorPerformance() }
        .sheet(isPresented: $showTradingDates) {
            TradingDates()
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
