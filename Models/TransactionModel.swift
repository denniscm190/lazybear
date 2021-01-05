//
//  Insiders.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 4/1/21.
//

import SwiftUI

struct TransactionModel: Codable, Hashable {
    var acquisition_disposition: String
    var transaction_date: String
    var reporting_owner: String
    var transaction_type: String
    var number_securities_transacted: Int
}
