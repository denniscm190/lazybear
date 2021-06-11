//
//  ConvertStringToDate.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 7/6/21.
//

import SwiftUI

/*
 Convert String to date with the format specified
 */
func convertStringToDate(_ stringDate: String) -> Date {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd"
    
    let date = dateFormatter.date(from: stringDate)!
    
    return date
}
