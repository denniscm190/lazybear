//
//  Profile.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 7/5/21.
//

import SwiftUI

class Profile: ObservableObject {
    @Published var showView = false
    @Published var data = ProfileResponse()
    
    func request(_ url: String, _ requestType: RequestType) {
        genericRequest(url: url, model: ProfileResponse.self) { response in
            switch requestType {
            case .initial:
                self.data = response
            default:
                self.data.quotes = response.quotes
            }
            
            self.showView = true
        }
    }
}
