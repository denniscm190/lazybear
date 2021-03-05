//
//  InsiderModel.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 5/3/21.
//

import SwiftUI

struct InsiderTranModel: Codable, Hashable {
    var directIndirect: String?
    var transactionDate: String?
    var fullName: String?
    var postShares: Int?
    var transactionCode: String?
    var transactionPrice: Float?
    var transactionShares: Int?
    var transactionValue: Float?
    
}
