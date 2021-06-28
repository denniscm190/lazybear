//
//  ConvertEpoch.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 28/3/21.
//

import SwiftUI

/*
 Convert Epoch time (in miliseconds) to human readable date
 */
func convertEpoch(_ miliseconds: Int64, _ interval: Bool) -> String {
    let now = Date() // Current date
    
    // TimeInterval() function must be in seconds, not in miliseconds
    let convertedDate = Date(timeIntervalSince1970: TimeInterval(miliseconds/1000))
    
    let formatter = DateComponentsFormatter()
    formatter.unitsStyle = .abbreviated
    
    let dateFormatter = DateFormatter()
    dateFormatter.dateStyle = .medium
    
    var humanDate = String()
    if interval {
        humanDate = formatter.string(from: convertedDate, to: now)!
    } else {
        humanDate = dateFormatter.string(from: convertedDate)
    }
    
    return humanDate
}
