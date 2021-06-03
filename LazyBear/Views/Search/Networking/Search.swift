//
//  Search.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 16/4/21.
//

import SwiftUI
import Bazooka

class Search: ObservableObject {
    @Published var data = [SearchResponse()]
    @Published var showSearchList = false
    
    func request(_ url: String) {
        let bazooka = Bazooka()
        bazooka.request(url: url, model: [SearchResponse].self) { response in
            self.data = response
            self.showSearchList = true
        }
    }
}
