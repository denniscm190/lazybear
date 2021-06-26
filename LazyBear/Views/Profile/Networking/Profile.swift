//
//  Profile.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 7/5/21.
//

import SwiftUI
import Alamofire

class Profile: ObservableObject {
    @Published var showView = false
    @Published var data = ProfileResponse()
    
    func request(_ url: String, _ requestType: RequestType) {
        AF.request(url).responseDecodable(of: ProfileResponse.self) { response in
            if let value = response.value {
                switch requestType {
                case .initial:
                    self.data = value
                default:
                    self.data = value
                }

                self.showView = true
            }
        }
    }
}
