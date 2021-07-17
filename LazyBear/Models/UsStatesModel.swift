//
//  UsStatesModel.swift
//  lazybear
//
//  Created by Dennis Concepción Martín on 17/07/2021.
//

import SwiftUI
import MapKit

struct UsStatesModel: Codable {
    var state: String
    var latitude: CLLocationDegrees
    var longitude: CLLocationDegrees
}
