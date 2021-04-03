//
//  TradingDate.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 30/3/21.
//

import SwiftUI

enum DateType {
    case holidays, trading
}

struct TradingDates: View {
    @State private var dates = [TradingDatesModel]()
    @State private var showingView = false
    
    private let baseUrl = Bundle.main.infoDictionary?["IEX_URL"] as? String ?? "Empty url"
    private let apiKey = Bundle.main.infoDictionary?["IEX_API"] as? String ?? "Empty key"
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    ForEach(getArrayOfDates(), id: \.self) { date in
                        TradingDatesItem(date: date)
                    }
                }
                .padding()
            }
            .onAppear { requestDates(.holidays) }
            .navigationTitle("Holiday dates")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    
    private func requestDates(_ dateType: DateType) {
        switch dateType {
        case .trading:
            let tradingUrl = "\(baseUrl)/ref-data/us/dates/trade/next/10?token=\(apiKey)"
            genericRequest(url: tradingUrl, model: [TradingDatesModel].self) {
                self.dates = $0
                self.showingView = true
            }
        case.holidays:
            let holidaysUrl = "\(baseUrl)/ref-data/us/dates/holiday/next/10?token=\(apiKey)"
            genericRequest(url: holidaysUrl, model: [TradingDatesModel].self) {
                self.dates = $0
                self.showingView = true
            }
        }
    }
    
    private func getArrayOfDates() -> [Date] {
        // Get array of the string dates
        let stringDates = self.dates.map { $0.date }
        
        // Convert string to date
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        // Append dates to a Date array
        var dates = [Date]()
        for stringDate in stringDates {
            dates.append(dateFormatter.date(from: stringDate)!)
        }
        
        return dates
    }
}

struct TradingDate_Previews: PreviewProvider {
    static var previews: some View {
        // Format is YYY-MM-DD
        TradingDates()
    }
}
