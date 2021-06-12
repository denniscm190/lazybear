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
    @State private var timer = Timer.publish(every: 10, on: .main, in: .common).autoconnect()  /// Set recurrent price request
    
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
                        let mirror = Mirror(reflecting: lists)
                        ForEach(Array(mirror.children), id: \.label) { child in
                            if let list = child.value as? [String : QuoteModel] {
                                StockRow(listName: "\(adaptListTitle(child.label!))", list: list, intradayPrices: home.data.intradayPrices, addOnDelete: false)
                                    .listRowInsets(EdgeInsets())
                            }
                        }
                    }
                    if let latestCurrencies = home.data.latestCurrencies {
                        CurrencyRow(latestCurrencies: latestCurrencies)
                            .listRowInsets(EdgeInsets())
                    }
                }
                .onAppear { self.timer = Timer.publish(every: 10, on: .main, in: .common).autoconnect() }  /// Restart timer
                .onReceive(timer) { _ in home.request("https://api.lazybear.app/home/type=streaming", .streaming) }  /// Receive timer notification
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
                    home.request("https://api.lazybear.app/home/type=init", .initial)
                }

        }
    }
    
    /*
     Get list keys (mostactive, losers, active) and adapt them to diplay
     */
    private func adaptListTitle(_ title: String) -> String {
        if title == "mostactive" {
            return "Most active"
        } else {
            return title.capitalized
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
