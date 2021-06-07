//
//  ConvertStringToDate.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 7/6/21.
//

import SwiftUI

func convertStringToDate(_ stringDate: String) -> Date {
    // Convert string to date
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd"
    
    let date = dateFormatter.date(from: stringDate)!
    
    return date
}
