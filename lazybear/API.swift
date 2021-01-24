//
//  API.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 24/1/21.
//

import SwiftUI

struct API {
    enum BaseURL {
        case sandbox
        case production
        
        var path: (String, String) {
            let token = Token()
            switch self {
            case .sandbox:
                return ("https://sandbox.iexapis.com", token.sandbox)
            case .production:
                return ("https://cloud.iexapis.com", token.production)
            }
        }
    }

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
        var path: String {
            switch self {
            case .historicalPrices:
                return "/chart"
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
    func getURL(baseURL: BaseURL, version: Version, stock: Stock, endpoint: Endpoint, range: Range, parameters: Parameters) -> String {
        let (baseURL, token) = baseURL.path
        let version = version.path
        let stock = stock.path
        let endpoint = endpoint.path
        let range = range.path
        let parameters = parameters.path
        
        let url = "\(baseURL)\(version)\(stock)\(endpoint)\(range)\(parameters)&token=\(token)"
        
        return url
        
    }
    
    // Request API
    func request<T: Decodable>(url: String, model: T.Type, completion: @escaping (T) -> Void) {
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
