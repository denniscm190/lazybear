//
//  WatchlistCreatorClass.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 30/4/21.
//

import SwiftUI

class WatchlistCreatorClass: ObservableObject {
    @Published var name = String()
    @Published var companies = [SearchResponse]()
}
