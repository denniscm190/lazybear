//
//  KeyStatsModel.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 9/6/21.
//

import SwiftUI

struct KeyStatsModel: Codable {
    var avg10Volume, avg30Volume: Int?
    var beta: Double?
    var companyName: String?
    var day200MovingAvg, day30ChangePercent, day50MovingAvg, day5ChangePercent: Double?
    var dividendYield: Double?
    var employees: Int?
    var exDividendDate: String?
    var float, marketcap: Int?
    var maxChangePercent, month1ChangePercent, month3ChangePercent, month6ChangePercent: Double?
    var nextDividendDate, nextEarningsDate: String?
    var peRatio: Double?
    var sharesOutstanding: Int?
    var ttmDividendRate, ttmEPS, week52Change, week52High: Double?
    var week52HighSplitAdjustOnly, week52Low: Double?
    var week52LowSplitAdjustOnly: Double?
    var year1ChangePercent, year2ChangePercent, year5ChangePercent, ytdChangePercent: Double?

    enum CodingKeys: String, CodingKey {
        case avg10Volume, avg30Volume, beta, companyName, day200MovingAvg, day30ChangePercent, day50MovingAvg, day5ChangePercent, dividendYield, employees, exDividendDate, float, marketcap, maxChangePercent, month1ChangePercent, month3ChangePercent, month6ChangePercent, nextDividendDate, nextEarningsDate, peRatio, sharesOutstanding, ttmDividendRate, ttmEPS
        case week52Change = "week52change"
        case week52High = "week52high"
        case week52HighSplitAdjustOnly = "week52highSplitAdjustOnly"
        case week52Low = "week52low"
        case week52LowSplitAdjustOnly = "week52lowSplitAdjustOnly"
        case year1ChangePercent, year2ChangePercent, year5ChangePercent, ytdChangePercent
    }
}
