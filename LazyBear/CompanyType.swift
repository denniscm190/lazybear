//
//  CompanyType.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 12/3/21.
//

import SwiftUI

class CompanyType: ObservableObject {
    @Published var view = ViewType.stock
}

enum ViewType {
    case stock, insiders
}
