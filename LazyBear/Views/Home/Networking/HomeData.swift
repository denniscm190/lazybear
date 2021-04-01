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
    @Published var list = ["mostactive": [CompanyRowModel](), "gainers": [CompanyRowModel](), "losers": [CompanyRowModel]()]
    @Published var intradayPrices = [String(): IntradayPricesArray(intradayPrices: [IntradayPricesModel(open: Double())])]
    @Published var holidayDates = [TradingDatesModel]()
    
    private let baseUrl = Bundle.main.infoDictionary?["IEX_URL"] as? String ?? "Empty url"
    private let apiKey = Bundle.main.infoDictionary?["IEX_API"] as? String ?? "Empty key"
    
    // Call this function to make the request
    func request() {
        let dispatchGroup = DispatchGroup()  // Start dispatch group
        var url = String()
        
//      1. SECTOR PERFORMANCE REQUEST
        url = "\(baseUrl)/stock/market/sector-performance?token=\(apiKey)"
        print("Entering group: request Sector Performance")
        dispatchGroup.enter()  // Enter group
        
        // API Request
        genericRequest(url: url, model: [SectorPerformanceModel].self) {
            self.sectorPerformance = $0
            print("Leaving group: request Sector Performance")
            dispatchGroup.leave()  // Leave group
        }
        
//      2. LISTS REQUEST
        var symbols = [String]()  // Know what symbols are in each list
        for key in self.list.keys {
            url = "\(baseUrl)/stock/market/collection/list?collectionName=\(key)&token=\(apiKey)"
            print("Entering group: request list \(key)")
            dispatchGroup.enter()  // Enter group
            
            // API Request
            genericRequest(url: url, model: [CompanyRowModel].self) {
                self.list[key] = $0
                print("Leaving group: request list \(key)")
                dispatchGroup.leave()
                
                // Append symbols requested to a list
                if let companies = self.list[key] {  // Unwrap value
                    for company in companies {  // Iterate inside the list through the companies
                        symbols.append(company.symbol)
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
            }
        }
        
//      3. REQUEST TRADING/HOLIDAY DAYS
        url = "\(baseUrl)/ref-data/us/dates/holiday/next/30?token=\(apiKey)"
        print("Entering group: request Trading/holiday Days")
        dispatchGroup.enter()  // Enter group
        genericRequest(url: url, model: [TradingDatesModel].self) {
            self.holidayDates = $0
            
            print("Leaving group: request Trading/holiday Days")
            dispatchGroup.leave()
        
       }
        
        // This will run after the ForLoop and if it was successful
        dispatchGroup.notify(queue: .main) {
            
//           4. INTRADAY PRICES REQUEST
            // Once the previous request are made, I can append the final part of the url and make the request
            url = "\(url)&types=intraday-prices&token=\(self.apiKey)"
            genericRequest(url: url, model: [String: IntradayPricesArray].self) {
                self.intradayPrices = $0
                
                print("Request done successfully -> showing view")
                self.showView = true
            }
        }
    }
}


