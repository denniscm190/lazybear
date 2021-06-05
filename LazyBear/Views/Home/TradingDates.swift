//
//  TradingDate.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 30/3/21.
//

import SwiftUI


struct TradingDates: View {
    var dates: [TradingDatesModel]
    @Environment(\.presentationMode) var tradingDatesPresent
    
    let columns = [GridItem(.adaptive(minimum: 100))]
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 20) {
                    ForEach(getArrayOfDates(), id: \.self) { date in
                        TradingDatesItem(date: date)
                    }
                }
                .padding()
            }
            .navigationTitle("Holiday dates")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: { tradingDatesPresent.wrappedValue.dismiss() }) {
                        Image(systemName: "multiply")
                            .imageScale(.large)
                    }
                }
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
        // Format is YYYY-MM-DD
        TradingDates(dates: [TradingDatesModel(date: "2021-01-01")])
    }
}
