//
//  StatsView.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 9/6/21.
//

import SwiftUI

struct StatsView: View {
    var keyStats: KeyStatsModel
    @Environment(\.presentationMode) private var presentationStatsView
    
    var body: some View {
        NavigationView {
            Form {
                let mirror = Mirror(reflecting: keyStats)
                ForEach(Array(mirror.children), id: \.label) { child in
                    HStack {
                        let label = String(child.label!)
                        
                        Text("\(label)".capitalized)
                            .fontWeight(.semibold)
                        
                        // Unwrap optional value
                        if let doubleValue = child.value as? Double {
                            Text("\(doubleValue)")
                        } else if let intValue = child.value as? Int {
                            Text("\(intValue)")
                        } else if let stringValue = child.value as? String {
                            Text("\(stringValue)")
                        } else {
                            Text("NaN")
                        }
                    }
                }
            }
            .navigationTitle("Key statistics")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: { presentationStatsView.wrappedValue.dismiss() }) {
                        Image(systemName: "multiply")
                            .imageScale(.large)
                    }
                }
            }
        }
    }
}


struct StatsView_Previews: PreviewProvider {
    static var previews: some View {
        StatsView(keyStats:
                KeyStatsModel(avg10Volume: 123,
                              avg30Volume: 123,
                              beta: 123.12,
                              companyName: "Apple inc",
                              day200MovingAvg: 123.4,
                              day30ChangePercent: 123.4,
                              day50MovingAvg: 123.4,
                              day5ChangePercent: 123.4,
                              dividendYield: 123.4,
                              employees: 123,
                              exDividendDate: "2020-01-01",
                              float: 123,
                              marketcap: 123,
                              maxChangePercent: 123.4,
                              month1ChangePercent: 123.4,
                              month3ChangePercent: 123.4,
                              month6ChangePercent: 123.4,
                              nextDividendDate: "2020-01-01",
                              nextEarningsDate: "2020-01-01",
                              peRatio: 123.4,
                              sharesOutstanding: 123,
                              ttmDividendRate: 123.4,
                              ttmEPS: 123.4,
                              week52Change: 123.4,
                              week52High: 123.4,
                              week52HighSplitAdjustOnly: 123.4,
                              week52Low: 123.4,
                              week52LowSplitAdjustOnly: 123.4,
                              year1ChangePercent: 123.4,
                              year2ChangePercent: 123.4,
                              year5ChangePercent: 123.4,
                              ytdChangePercent: 123.4
                )
        )
    }
}
