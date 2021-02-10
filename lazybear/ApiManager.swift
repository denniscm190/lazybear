//
//  EnvEndpoints.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 29/1/21.
//

import Foundation

class ApiManager: ObservableObject {
    @Published var results = [ApiManagerModel]()
    @Published var showingView = false
    @Published var option = 1  // 1 -> Sandbox / 2 -> Production
}
