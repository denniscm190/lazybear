//
//  InsiderTransactions.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 1/2/21.
//

import Foundation

struct InsiderTransactionModel: Codable, Hashable {
    var conversionOrExercisePrice: Float?
    var directIndirect: String?
    var filingDate: String?
    var fullName: String?
    var postShares: Float?
    var reportedTitle: String?
    var transactionCode: String?
    var transactionDate: String?
    var transactionPrice: Float?
    var transactionShares: Int?
    var transactionValue: Double?
}
