//
//  Profile.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 7/5/21.
//

import SwiftUI
import Bazooka

class Profile: ObservableObject {
    @Published var showView = false
    @Published var data = ProfileResponse()
    
    func request(_ url: String, _ requestType: RequestType) {
        let bazooka = Bazooka()
        bazooka.request(url: url, model: ProfileResponse.self) { response in
            switch requestType {
            case .initial:
                self.data = response
            default:
                self.data = response
            }
            
            self.showView = true
        }
    }
}
