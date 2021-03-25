//
//  EnvironmentSignUp.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 25/3/21.
//

import SwiftUI

class EnvironmentSignUp: ObservableObject {
    @Published var username = ""
    @Published var avatar = "random4"
    @Published var hideAvatarSelector = false
}
