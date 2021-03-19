//
//  PriceChartIndicator.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 18/3/21.
//

import SwiftUI

struct PriceChartIndicator: View {
    var prices: [Double]
    var dates: [String]
    var minutes: [String?]
    @Binding var indexValue: Int
    @FetchRequest(entity: UserSettings.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \UserSettings.changedAt, ascending: false)])
    var userSettings: FetchedResults<UserSettings>
    
    var body: some View {
        let colour = Color("\(userSettings.first?.theme?.lowercased() ?? "default")Accent")
        HStack {
            Group {
                let date = convertStringToDate(dates[indexValue])
                Text(date)
                if let minute = minutes[indexValue] {
                    Text(minute)
                }
                Text("\(prices[indexValue], specifier: "%.2f")")
                    .foregroundColor(colour)
            }
            .font(.subheadline)
        }
    }
}

struct PriceChartIndicator_Previews: PreviewProvider {
    static var previews: some View {
        PriceChartIndicator(prices: [100, 50], dates: ["10-10-2020", "11-10-2020"], minutes: ["9:02", "9:03"], indexValue: .constant(0))
    }
}
