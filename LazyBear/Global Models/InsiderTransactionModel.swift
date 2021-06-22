//
//  InsiderTransactionModel.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 7/6/21.
//

import SwiftUI

struct InsiderTransactionModel: Codable, Hashable {
    var filingDate: String
    var fullName: String
    var postShares: Float?
    var reportedTitle: String?
    var transactionCode: String
    var transactionPrice: Float?
    var transactionShares: Int?
    var transactionValue: Float?
}
