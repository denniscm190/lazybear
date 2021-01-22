//
//  ShowingCompany.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 22/1/21.
//

import SwiftUI

class ShowingCompany: ObservableObject {
    @Published var isShowing: Bool = false {
        didSet {
            print("Company is showing -> " + String(isShowing))
        }
    }
}
