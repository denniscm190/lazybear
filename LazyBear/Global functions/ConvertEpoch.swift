//
//  ConvertEpoch.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 28/3/21.
//

import SwiftUI

// Convert Epoch time to human date
func convertEpoch(_ miliseconds: Int) -> String {
    let now = Date() // Current date
    // TimeInterval() function must be in seconds, not in miliseconds
    let articlePublished = Date(timeIntervalSince1970: TimeInterval(miliseconds/1000))
    let formatter = DateComponentsFormatter()
    formatter.unitsStyle = .abbreviated
    let humanDate = formatter.string(from: articlePublished, to: now)!
    
    return humanDate
}
