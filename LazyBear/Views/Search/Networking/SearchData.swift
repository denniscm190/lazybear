//
//  SearchData.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 3/4/21.
//

import SwiftUI

class SearchData: ObservableObject {
    @Published var searchResult = [SearchModel]()
    
    private let baseUrl = Bundle.main.infoDictionary?["IEX_URL"] as? String ?? "Empty url"
    private let apiKey = Bundle.main.infoDictionary?["IEX_API"] as? String ?? "Empty key"
    
    func request(_ searchedText: String) {
        let url = "\(baseUrl)/search/\(searchedText)?token=\(apiKey)"
        
        genericRequest(url: url, model: [SearchModel].self) {
            self.searchResult = $0
        }
    }
}
