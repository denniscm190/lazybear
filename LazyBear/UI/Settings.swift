//
//  Settings.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 19/2/21.
//

import SwiftUI
import CoreData

struct Settings: View {
    @FetchRequest(entity: UserSettings.entity(),
                  sortDescriptors: [NSSortDescriptor(keyPath: \UserSettings.changedAt, ascending: false)])
    var userSettings: FetchedResults<UserSettings>
    
    var body: some View {
        NavigationView {
            Form {
                let theme = userSettings.first?.theme ?? "Default"
                let language = userSettings.first?.newsLanguage ?? "en"
                ThemePicker(theme: theme)
                NewsLanguagePicker(language: language)
                
                Section {
                    SettingRow(image: "at", text: "About", colour: .systemBlue)
                    SettingRow(image: "bag.fill", text: "Tip jar", colour: .systemGreen)
                    SettingRow(image: "suit.heart.fill", text: "Rate Lazybear", colour: .systemRed)
                    
                }
            }
            .navigationTitle("Settings 👨🏻‍🔧")
        }
    }
}


struct Settings_Previews: PreviewProvider {
    static var previews: some View {
        return Settings()
    }
}
