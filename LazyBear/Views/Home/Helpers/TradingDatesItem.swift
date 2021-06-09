//
//  TradingDatesItem.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 30/3/21.
//

import SwiftUI

struct TradingDatesItem: View {
    var date: Date
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        RoundedRectangle(cornerRadius: 20)
            .foregroundColor(Color(.secondarySystemBackground))
            .frame(width: 100, height: 100)
            .overlay(
                VStack {
                    Text(getDateComponents(.month, date))
                        .fontWeight(.semibold)
                    
                    Text(getDateComponents(.day, date))
                        .font(.title)
                        .fontWeight(.semibold)
                        .foregroundColor(Color(.systemBlue))
                    
                    Text(getDateComponents(.year, date))
                        .font(.caption)
                        .fontWeight(.semibold)
                }
            )
    }
}

struct TradingDatesItem_Previews: PreviewProvider {
    static var previews: some View {
        TradingDatesItem(date: Date())
    }
}
