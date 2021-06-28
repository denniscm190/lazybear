//
//  KeyStatsModel.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 9/6/21.
//

import SwiftUI

struct KeyStatsModel: Codable {
    var companyName: String?
    var employees: Float?
    var marketcap: Float?
    var float: Float?
    var sharesOutstanding: Float?
    
    var beta: Float?
    var peRatio: Float?
    var dividendYield: Float?
    var ttmDividendRate: Float?
    var ttmEPS: Float?
    
    var avg10Volume: Float?
    var avg30Volume: Float?

    var day50MovingAvg: Float?
    var day200MovingAvg: Float?
    
    var week52Change: Float?
    var week52High: Float?
    var week52Low: Float?
    var week52HighSplitAdjustOnly: Float?
    var week52LowSplitAdjustOnly: Float?
    
    var maxChangePercent: Float?
    var ytdChangePercent: Float?
    var day5ChangePercent: Float?
    var day30ChangePercent: Float?
    var month1ChangePercent: Float?
    var month3ChangePercent: Float?
    var month6ChangePercent: Float?
    var year1ChangePercent: Float?
    var year2ChangePercent: Float?
    var year5ChangePercent: Float?
    
    var exDividendDate: String?
    var nextDividendDate: String?
    var nextEarningsDate: String?
}
