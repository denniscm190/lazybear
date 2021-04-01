//
//  TradingDate.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 30/3/21.
//

import SwiftUI

struct TradingDates: View {
    var stringDates: [TradingDatesModel]
    
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
            .navigationTitle("Holiday dates")
        }
    }
    
    
    private func getArrayOfDates() -> [Date] {
        // Get array of the string dates
        let stringDates = self.stringDates.map { $0.date }
        
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
        TradingDates(stringDates: [TradingDatesModel(date: "2020-04-01")])
    }
}
