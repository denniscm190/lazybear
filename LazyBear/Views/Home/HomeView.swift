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
    @State private var timer = Timer.publish(every: 10, on: .main, in: .common).autoconnect()  // Set recurrent price request
    
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
                
                // Get keys of the dictionary list
                ForEach(homeData.list.keys.sorted(), id: \.self) { key in
                    TopStockRow(key: key, list: homeData.list[key] ?? [CompanyRowModel](), intradayPricesDict: homeData.intradayPrices)
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
            }
        }
        .onAppear { homeData.get() }
        .onReceive(timer) {_ in homeData.get() }
        .sheet(isPresented: $showTradingDates) {
            TradingDates(stringDates: homeData.holidayDates)
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
