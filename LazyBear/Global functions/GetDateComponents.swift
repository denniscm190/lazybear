//
//  GetDateComponents.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 7/6/21.
//

import SwiftUI

enum Components {
    case day, month, year
}

/*
 Get components from a date
 */
func getDateComponents(_ components: Components, _ date: Date) -> String {
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
