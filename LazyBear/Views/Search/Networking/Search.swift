//
//  Search.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 16/4/21.
//

import SwiftUI
import Alamofire

class Search: ObservableObject {
    @Published var data = [SearchResponse()]
    @Published var showSearchList = false
    
    func request(_ url: String) {
        AF.request(url).responseDecodable(of: [SearchResponse].self) { response in
            if let value = response.value {
                self.data = value
                self.showSearchList = true
            }
        }
    }
}
