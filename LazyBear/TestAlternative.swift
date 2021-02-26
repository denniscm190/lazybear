//
//  TestAlternative.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 26/2/21.
//

import SwiftUI

struct TestAlternative: View {
    var body: some View {
        VStack {
            Button(action: { UIApplication.shared.setAlternateIconName(nil) }) {
                Text("Default")
            }
            Button(action: { changeIcon(key: "AppIcon-1") }) {
                Text("Angry")
            }
        }
    }
    
    private func changeIcon(key: String) {
        UIApplication.shared.setAlternateIconName(key) { error in
            if let error = error {
                print(error.localizedDescription)
            } else {
                print("Success!")
            }
        }
    }
}

struct TestAlternative_Previews: PreviewProvider {
    static var previews: some View {
        TestAlternative()
    }
}
