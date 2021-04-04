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
    // Set recurrent price request
    @State private var timer = Timer.publish(every: 10, on: .main, in: .common).autoconnect()
    
    static let taskDateFormat: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter
        }()

        let dueDate = Date()
    
    var body: some View {
        if homeData.showView {
            NavigationView {
                List {
                    SectorRow(sectorPerformance: homeData.sectorPerformance)
                        .listRowInsets(EdgeInsets())
                        
                    // Get keys of the dictionary list
                    ForEach(homeData.topLists.keys.sorted(), id: \.self) { listType in
                        if let list = homeData.topLists[listType] {
                            TopStockRow(listType: listType, list: list)
                        }
                    }
                    .listRowInsets(EdgeInsets())
                }
                .onReceive(timer) { _ in homeData.request() }
                .onDisappear { self.timer.upstream.connect().cancel() }  // Stop timer
                .navigationTitle("\(dueDate, formatter: Self.taskDateFormat)")
                .navigationBarTitleDisplayMode(.inline)
                .navigationViewStyle(StackNavigationViewStyle())
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button(action: { showTradingDates = true }) {
                            Image(systemName: "calendar.badge.clock")
                        }
                    }
                }
            }
            .sheet(isPresented: $showTradingDates) {
                TradingDates()
            }
        } else {
            ProgressView()
                .onAppear {
                    homeData.request()
                    // Restart timer
                    self.timer = Timer.publish(every: 10, on: .main, in: .common).autoconnect()
                }
            
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
