//
//  CompanyInfoModel.swift
//  lazybear
//
//  Created by Dennis Concepción Martín on 17/07/2021.
//

import SwiftUI

struct CompanyInfoModel: Codable {
    var symbol: String?
    var companyName: String?
    var description: String?
    var address: String?
    var state: String?
    var country: String?
}
