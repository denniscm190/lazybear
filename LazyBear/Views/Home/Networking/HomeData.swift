//
//  HomeData.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 1/4/21.
//

import SwiftUI

class HomeData: ObservableObject {
    @Published var showView = false
    
    // Data
    @Published var sectorPerformance = [SectorPerformanceModel]()
    @Published var topLists = [String(): [CompanyQuoteModel]()]
    @Published var intradayPrices = [String(): [IntradayPricesResult]()]
    
    private var symbolsInLists = [String()]
    private let baseUrl = Bundle.main.infoDictionary?["IEX_URL"] as? String ?? "Empty url"
    private let apiKey = Bundle.main.infoDictionary?["IEX_API"] as? String ?? "Empty key"
    
    
    func get() {
        let dispatchGroup = DispatchGroup()
        var url = String()
        
        // 1. SECTOR PERFORMANCE REQUEST
        url = "\(baseUrl)/stock/market/sector-performance?token=\(apiKey)"
        dispatchGroup.enter()
        
        genericRequest(url: url, model: [SectorPerformanceModel].self) {
            self.sectorPerformance = $0
            dispatchGroup.leave()
        }
        
        // 2. STOCK LISTS REQUEST
        let listTypes = ["mostactive", "losers", "gainers"]
        for listType in listTypes {
            url = "\(baseUrl)/stock/market/list/\(listType)?token=\(apiKey)"
            dispatchGroup.enter()
            
            genericRequest(url: url, model: [CompanyQuoteModel].self) { list in
                self.topLists[listType] = list
                // Append symbols in list to array
                for company in list {
                    self.symbolsInLists.append(company.symbol)
                }
        
                dispatchGroup.leave()
            }
        }
        
        dispatchGroup.notify(queue: .main) {
            if self.intradayPrices.count == 1 {
                self.getIntradayPrices()
            } else {
                self.showView = true
            }
        }
    }
    
    // 3. INTRADAY PRICES REQUEST
    func getIntradayPrices() {
        var url = "\(baseUrl)/stock/market/batch?symbols="
        
        var counter = 0
        for symbol in symbolsInLists {
            counter += 1
            if counter == 1 {
                url += symbol
            } else {
                url += ",\(symbol)"
            }
        }
        
        url += "&types=intradayprices&token=\(apiKey)"
        
        genericRequest(url: url, model: [String: IntradayPricesBatch].self) { dict in
            for symbol in dict.keys {
                self.intradayPrices[symbol] = dict[symbol]?.intradayprices
            }
            
            self.showView = true
        }
    }
}


