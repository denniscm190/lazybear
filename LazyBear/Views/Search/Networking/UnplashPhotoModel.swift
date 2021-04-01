//
//  UnplashPhotoModel.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 1/4/21.
//

import SwiftUI

struct UnplashPhotoResponse: Codable {
    var results: [UnplashPhotoModel]
}
struct UnplashPhotoModel: Codable {
    var urls: UnplashPhotoUrls
    var user: String
}

struct UnplashPhotoUrls: Codable {
    var small: String
}

struct UnplashPhotoUser: Codable {
    var username: String
    var name: String
    var firstName: String
    var lastName: String
    
    // Change key name
    private enum CodingKeys : String, CodingKey {
        case username, name
        case firstName = "first_name"
        case lastName = "last_name"
    }
}
// URL-> https://api.unsplash.com/search/photos?page=1&per_page=1&order_by=popular&query=office&client_id=FGNeBoqvo838iKn05re3kxbTAlpnc1fBdsyts3n6uyo
