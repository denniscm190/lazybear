//
//  DateToString.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 19/3/21.
//

import SwiftUI

func convertStringToDate(_ stringDate: String) -> String {
    // Convert string to date
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yy-MM-dd"
    let date = dateFormatter.date(from: stringDate)
    
    // Format date to the final format
    dateFormatter.dateStyle = .long
    let finalDate = dateFormatter.string(from: date!)
    
    return finalDate
}
