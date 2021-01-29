//
//  API.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 24/1/21.
//

import SwiftUI

struct IexApi {
    @EnvironmentObject var apiAccess: ApiAccess  // Env apis info
    
    enum Version {
        case stable
        
        var path: String {
            switch self {
            case .stable:
                return "/stable"
            }
        }
    }
    
    enum Stock {
        case symbol(company: String)
        var path: String {
            switch self {
            case let .symbol(company):
                return "/stock/\(company)"
            }
        }
    }

    enum Endpoint {
        case historicalPrices
        case quote
        var path: String {
            switch self {
            case .historicalPrices:
                return "/chart"
            case .quote:
                return "/quote?"
            }
        }
    }
    
    enum Range {
        case period(range: String)
        var path: String {
            switch self {
            case let .period(range):
                return "/\(range)?"
            }
        }
    }
    
    enum Parameters {
        case chartCloseOnly
        var path: String {
            switch self {
            case .chartCloseOnly:
                return "chartCloseOnly=true"
            }
        }
    }
    
    
    // Create URL
    func getPath(version: Version, stock: Stock, endpoint: Endpoint, range: Range?, parameters: Parameters?) -> String {
        let version = version.path
        let stock = stock.path
        let endpoint = endpoint.path
        let range = range?.path
        let parameters = parameters?.path
        
        let path = "\(version)\(stock)\(endpoint)\(range ?? "")\(parameters ?? "")token="
        
        return path
        
    }
    
    // Request API
    func request<T: Decodable>(url: String, model: T.Type, completion: @escaping (_ result: T) -> Void) {
        // We take some model data T.Type
        guard let url = URL(string: url) else {
            print("Invalid URL")
            return
        }
        let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                do {
                    // Decode response with the model passed
                    let decodedResponse = try JSONDecoder().decode(model, from: data)
                    DispatchQueue.main.async {
                        print(decodedResponse)
                        completion(decodedResponse)
                    }
                    return
                } catch {
                    print(error)
                }
            }
            print("Fetch failed: \(error?.localizedDescription ?? "Unknown error")")
        }
        .resume()
    }
}
