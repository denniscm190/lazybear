//
//  HomeView.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 28/3/21.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject var home = Home()
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
        if home.showView {
            NavigationView {
                List {
                    if let sectorPerformance = home.data.sectorPerformance {
                        SectorRow(sectorPerformance: sectorPerformance)
                            .listRowInsets(EdgeInsets())
                    }
                    
                    if let lists = home.data.lists {
                        if let gainers = lists.gainers {
                            StockRow(listName: "Gainers", list: gainers, intradayPrices: home.data.intradayPrices, addOnDelete: false)
                                .listRowInsets(EdgeInsets())
                        }
                        if let losers = lists.losers {
                            StockRow(listName: "Losers", list: losers, intradayPrices: home.data.intradayPrices, addOnDelete: false)
                                .listRowInsets(EdgeInsets())
                        }
                        if let mostActive = lists.mostactive {
                            StockRow(listName: "Most active", list: mostActive, intradayPrices: home.data.intradayPrices, addOnDelete: false)
                                .listRowInsets(EdgeInsets())
                        }
                    }
                    if let latestCurrencies = home.data.latestCurrencies {
                        CurrencyRow(latestCurrencies: latestCurrencies)
                            .listRowInsets(EdgeInsets())
                    }
                }
                .onAppear { self.timer = Timer.publish(every: 10, on: .main, in: .common).autoconnect() }  // Start timer
                .onReceive(timer) { _ in home.request("https://api.lazybear.app/home/type=streaming", isInitRequest: false) }  // Receive timer notification
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
                if let dates = home.data.tradingDates {
                    TradingDates(dates: dates)
                }
            }
        } else {
            ProgressView()
                .onAppear {
                    home.request("https://api.lazybear.app/home/type=init", isInitRequest: true)
                }

        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
