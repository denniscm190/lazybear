//
//  ReadJson.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 31/12/20.
//

import SwiftUI

import SwiftUI

// With this function I parse the local JSON file to read it and create a list with its items.
let companiesData: [CompanyData] = load("companies.json")

func load<T: Decodable>(_ filename: String) -> T {
    let data: Data
    
    guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
        else {
            fatalError("Couldn't find \(filename) in main bundle.")
    }
    
    do {
        data = try Data(contentsOf: file)
    } catch {
        fatalError("Couldn't load \(filename) from main bundle:\n\(error)")
    }
    
    do {
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    } catch {
        fatalError("Couldn't parse \(filename) as \(T.self):\n\(error)")
    }
}
