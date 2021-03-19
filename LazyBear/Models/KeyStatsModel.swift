//
//  KeyStatsModel.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 19/3/21.
//

import SwiftUI

struct KeyStatsModel: Hashable, Codable {
    var Market_Cap: Double?
    var Weeks52_High: Double?
    var Weeks52_Low: Double?
    var Shares: Double?
    var Days10_Avg_Volume: Double?
    var Days30_Avg_Volume: Double?
    var Days200_Moving_Avg: Double?
    var Days50_Moving_Avg: Double?
    var Employees: Double?
    var Trailing_EPS: Double?
    var Trailing_Dividend_Rate: Double?
    var Dividend_Yield: Double?
    var Next_Dividend_Date: String?
    var PE_Ratio: Double?
    var Beta: Double?
    
    
    // Custom keys
    enum CodingKeys: String, CodingKey {
        case Market_Cap = "marketcap"
        case Weeks52_High = "week52high"
        case Weeks52_Low = "week52low"
        case Shares = "sharesOutstanding"
        case Days10_Avg_Volume = "avg10Volume"
        case Days30_Avg_Volume = "avg30Volume"
        case Days200_Moving_Avg = "day200MovingAvg"
        case Days50_Moving_Avg = "day50MovingAvg"
        case Employees = "employees"
        case Trailing_EPS = "ttmEPS"
        case Trailing_Dividend_Rate = "ttmDividendRate"
        case Dividend_Yield = "dividendYield"
        case Next_Dividend_Date = "nextDividendDate"
        case PE_Ratio = "peRatio"
        case Beta = "beta"
    }
}

