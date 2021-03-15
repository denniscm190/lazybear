//
//  DeviceSize.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 15/3/21.
//

import SwiftUI

class DeviceSize: ObservableObject {
    @Published var width = CGFloat(400)
    @Published var height = CGFloat(400)
}
