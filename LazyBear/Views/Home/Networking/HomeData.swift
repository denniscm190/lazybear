//
//  HomeData.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 1/4/21.
//

import SwiftUI

class HomeData: ObservableObject {
    @Published var showView = false
    @Published var sectorPerformance = [SectorPerformanceModel]()
    @Published var topLists = [
        "gainers": [CompanyQuoteModel](),
        "losers": [CompanyQuoteModel](),
        "mostactive": [CompanyQuoteModel]()
    ]
    
    private let baseUrl = Bundle.main.infoDictionary?["IEX_URL"] as? String ?? "Empty url"
    private let apiKey = Bundle.main.infoDictionary?["IEX_API"] as? String ?? "Empty key"
    
    
    func get() {
        let dispatchGroup = DispatchGroup()
        var url = String()
        
        // 1. REQUEST SECTOR PERFORMANCE
        url = "\(baseUrl)/stock/market/sector-performance?token=\(apiKey)"
        dispatchGroup.enter()
        
        genericRequest(url: url, model: [SectorPerformanceModel].self) {
            self.sectorPerformance = $0
            dispatchGroup.leave()
        }
        
        // 2. STOCK LISTS
        for listType in topLists.keys {
            url = "\(baseUrl)/stock/market/list/\(listType)?token=\(apiKey)"
            dispatchGroup.enter()
            
            genericRequest(url: url, model: [CompanyQuoteModel].self) {
                self.topLists[listType] = $0
                dispatchGroup.leave()
            }
        }
        
        dispatchGroup.notify(queue: .main) {
            self.showView = true
        }
    }
}


