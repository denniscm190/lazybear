//
//  Test.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 23/1/21.
//

import SwiftUI

// We take some model data T.Type
func loadData<T: Decodable>(model: T.Type, completion: @escaping (T) -> Void) {
    guard let url = URL(string: "") else {
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


struct Test: View {
    @State var results = [HistoricalPricesModel]()
    var body: some View {
        Text("Hello world")
            .onAppear {
                loadData(model: [HistoricalPricesModel].self) {
                    self.results = $0
                }
            }
    }
}
