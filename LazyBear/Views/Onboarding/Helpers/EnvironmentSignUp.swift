//
//  EnvironmentSignUp.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 25/3/21.
//

import SwiftUI

class EnvironmentSignUp: ObservableObject {
    @Published var hideAvatarSelector = false
    @Published var username = ""
    @Published var body = "body1"
    @Published var bodyColor = Color("custom2")
    @Published var eyes = "eyes3"
    @Published var facialHair = "facialHair4"
    @Published var hair = "hair13"
    @Published var hairColor = Color("hairColor1")
    @Published var mouth = "mouth4"
    @Published var nose = "nose2"
    @Published var skinTone = Color("skinTone2")
    @Published var background = Color("custom7")
}
