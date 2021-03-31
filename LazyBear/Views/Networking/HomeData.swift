//
//  HomeData.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 30/3/21.
//

import SwiftUI

class HomeData: ObservableObject {
    @Published var sectorPerformance = [SectorPerformanceModel]()
    @Published var list = ["mostactive": [CompanyRowModel](), "gainers": [CompanyRowModel](), "losers": [CompanyRowModel]()]
    @Published var intradayPrices = [String(): IntradayPricesArray(intradayPrices: [IntradayPricesModel(open: Double())])]
    
    private let baseUrl = Bundle.main.infoDictionary?["IEX_URL"] as? String ?? "Empty url"
    private let apiKey = Bundle.main.infoDictionary?["IEX_API"] as? String ?? "Empty key"
    
    // PRINCIPAL FUNCTION TO CALL
    func get() {
        // 1. Request sector performance
        var url = "\(baseUrl)/stock/market/sector-performance?token=\(apiKey)"
        request(url: url, model: [SectorPerformanceModel].self) { self.sectorPerformance = $0 }
        
        // 2. Request lists
        var semaphore = 0
        for key in self.list.keys {
            url = "\(self.baseUrl)/stock/market/collection/list?collectionName=\(key)&token=\(self.apiKey)"
            request(url: url, model: [CompanyRowModel].self) { self.list[key] = $0; semaphore += 1  // Finish modifying dictionary
                
                if semaphore == 3 {  // When dictionary is modified
                    
                    // 3. Request intraday prices
                    var symbols = [String]()
                    for key in self.list.keys {  // Iterate throught the list
                        if let companies = self.list[key] {  // Unwrap value
                            for company in companies {  // Iterate inside the list through the companies
                                symbols.append(company.symbol)  // Append symbol
                            }
                        }
                    }
                    
                    // Now that I have all the symbols I can request the intraday prices and save it to the @Published var
                    // First I have to concatenate the string to make the batch request
                    url = "\(self.baseUrl)/stock/market/batch?symbols="
                    for symbol in symbols {  // Concatenate symbol to the first part of the url
                        if symbols.firstIndex(of: symbol) == 0 {
                            url += symbol
                        } else {
                            url += ",\(symbol)"
                        }
                    }

                    // Once it's made, I can append the final part of the url and make the request
                    url = "\(url)&types=intraday-prices&token=\(self.apiKey)"
                    request(url: url, model: [String: IntradayPricesArray].self) { self.intradayPrices = $0 }
                }
            }
        }
    }
}
