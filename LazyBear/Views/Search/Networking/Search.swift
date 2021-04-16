//
//  Search.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 16/4/21.
//

import SwiftUI

class Search: ObservableObject {
    @Published var data = [SearchResponse()]
    @Published var showSearchList = false
    
    func request(_ url: String) {
        genericRequest(url: url, model: [SearchResponse].self) { response in
            self.data = response
            self.showSearchList = true
        }
    }
}
