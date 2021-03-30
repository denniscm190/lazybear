//
//  HomeData.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 30/3/21.
//

import SwiftUI

class HomeData: ObservableObject {
    @Published var sectorPerformance = [SectorPerformanceModel]() { didSet { print(sectorPerformance) }}
    
    
    let baseUrl = Bundle.main.infoDictionary?["IEX_URL"] as? String ?? "Empty url"
    let apiKey = Bundle.main.infoDictionary?["IEX_API"] as? String ?? "Empty key"
    
    func getSectorPerformance() {
        let url = "\(baseUrl)/stock/market/sector-performance?token=\(apiKey)"
        request(url: url, model: [SectorPerformanceModel].self) { self.sectorPerformance = $0 }
    }
}
