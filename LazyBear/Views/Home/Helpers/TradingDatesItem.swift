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
                    Text(get(.month))
                        .fontWeight(.semibold)
                    
                    Text(get(.day))
                        .font(.title)
                        .fontWeight(.semibold)
                        .foregroundColor(Color("default"))
                    
                    Text(get(.year))
                        .font(.caption)
                        .fontWeight(.semibold)
                }
            )
    }
    
    private enum Components {
        case day, month, year
    }
    
    private func get(_ components: Components) -> String {
        let dateComponents = Calendar.current.dateComponents([.year, .month, .day], from: date)
        
        switch components {
        case .year:
            return "\(dateComponents.year ?? 2020)"
        case .day:
            return "\(dateComponents.day ?? 1)"
        case .month:
            let dateFormatter = DateFormatter()
            let monthNumber = dateComponents.month ?? 1
            let monthLetters = dateFormatter.shortMonthSymbols[monthNumber-1]
            
            return "\(monthLetters)"
        }
        
    }
}

struct TradingDatesItem_Previews: PreviewProvider {
    static var previews: some View {
        TradingDatesItem(date: Date())
    }
}
