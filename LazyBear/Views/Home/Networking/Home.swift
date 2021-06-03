//
//  Home.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 11/4/21.
//

import SwiftUI
import Bazooka

class Home: ObservableObject {
    @Published var showView = false
    @Published var data = HomeResponse()
    
    func request(_ url: String, _ requestType: RequestType) {
        let bazooka = Bazooka()
        bazooka.request(url: url, model: HomeResponse.self) { response in
            switch requestType {
            case .initial:
                self.data = response
            default:
                self.data.lists = response.lists
                self.data.sectorPerformance = response.sectorPerformance
            }
            
            self.showView = true
        }
    }
}
