//
//  Request.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 20/2/21.
//

import Foundation

class Network: ObservableObject {
    @Published var showingProgress = false
    
    // Network request
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
                        //print(decodedResponse)
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
