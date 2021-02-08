//
//  Settings.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 6/2/21.
//

import SwiftUI

struct Settings: View {
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("")) {
                    Label("General", image: "")
                    Label("Appearance", image: "")
                    Label("Theme", image: "")
                    Label("App icon", image: "")
                }
    
                Section(header: Text("")) {
                    Label("About", image: "")
                    Label("Rate Lazybear", image: "")
                }
            }
            .navigationBarTitle("Settings", displayMode: .inline)
        }
    }
}

struct Settings_Previews: PreviewProvider {
    static var previews: some View {
        Settings()
    }
}
