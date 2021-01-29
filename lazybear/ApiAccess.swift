//
//  EnvEndpoints.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 29/1/21.
//

import SwiftUI
import CloudKit

class ApiAccess: ObservableObject {
    @Published var results = [ApiModel]()
    @Published var showingView = false
}
