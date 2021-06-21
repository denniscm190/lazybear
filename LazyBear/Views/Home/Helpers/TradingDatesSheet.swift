//
//  TradingDateSheet.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 30/3/21.
//

import SwiftUI


struct TradingDatesSheet: View {
    var dates: [String]
    @Environment(\.presentationMode) private var tradingDatesPresentation
    
    let columns = [GridItem(.adaptive(minimum: 100))]
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 20) {
                    ForEach(dates, id: \.self) { date in
                        TradingDatesItem(date: convertStringToDate(date))
                    }
                }
                .padding()
            }
            .navigationTitle("Holiday dates")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: { tradingDatesPresentation.wrappedValue.dismiss() }) {
                        Image(systemName: "multiply")
                            .imageScale(.large)
                    }
                }
            }
        }
    }
}

struct TradingDate_Previews: PreviewProvider {
    static var previews: some View {
        // Format is YYYY-MM-DD
        TradingDatesSheet(dates: ["2021-01-01"])
    }
}
