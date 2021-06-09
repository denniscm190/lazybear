//
//  KeyStatsModel.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 9/6/21.
//

import SwiftUI

struct KeyStatsModel: Codable {
    var companyName: String?
    var employees: Int?
    var marketcap: Int?
    var float: Int?
    var sharesOutstanding: Int?
    
    var beta: Double?
    var peRatio: Double?
    var dividendYield: Double?
    var ttmDividendRate: Double?
    var ttmEPS: Double?
    
    var avg10Volume: Int?
    var avg30Volume: Int?

    var day50MovingAvg: Double?
    var day200MovingAvg: Double?
    
    var week52Change: Double?
    var week52High: Double?
    var week52Low: Double?
    var week52HighSplitAdjustOnly: Double?
    var week52LowSplitAdjustOnly: Double?
    
    var maxChangePercent: Double?
    var ytdChangePercent: Double?
    var day5ChangePercent: Double?
    var day30ChangePercent: Double?
    var month1ChangePercent: Double?
    var month3ChangePercent: Double?
    var month6ChangePercent: Double?
    var year1ChangePercent: Double?
    var year2ChangePercent: Double?
    var year5ChangePercent: Double?
    
    var exDividendDate: String?
    var nextDividendDate: String?
    var nextEarningsDate: String?
}
