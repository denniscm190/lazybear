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
    let setting = SettingMetadata()
    @Environment(\.colorScheme) var colorScheme  // Detect dark mode
    
    var body: some View {
        NavigationView {
            Form {
                let theme = userSettings.first?.theme ?? "Default"
                let language = userSettings.first?.newsLanguage ?? "English"
                ThemePicker(theme: theme)
                NewsLanguagePicker(language: language)
                NavigationLink(destination: IconPicker()) {
                    Text("App icon")
                }
                
                Section(footer: IexAttribution(text: "Data provided by IEX Cloud").padding(.top)) {
                    ForEach((0...3), id: \.self) { index in
                        Link(destination: URL(string: setting.links[index])!) {
                            HStack {
                                SettingRow(image: setting.images[index], text: setting.texts[index], colour: setting.colours[index])
                                FakeLinkArrow()
                            }
                        }
                        .foregroundColor(colorScheme == .dark ? .white: .black)
                    }
                    
                    SettingRow(image: "bag.fill", text: "Tip jar", colour: .systemGreen)
                }
            }
            .navigationTitle("Settings 👨🏻‍🔧")
        }
    }
}

struct FakeLinkArrow: View {
    var body: some View {
        Spacer()
        Image(systemName: "chevron.right")
            .font(Font.body.weight(.semibold))
            .imageScale(.small)
            .opacity(0.2)
    }
}

class SettingMetadata {
    var links = ["https://lazybear.app",
                 "https://lazybear.app",
                 "https://github.com/DennisTechnologies/Lazybear-App/issues",
                 "https://github.com/DennisTechnologies/Lazybear-App/discussions"]
    
    var images = ["at", "suit.heart.fill", "ladybug.fill", "message.fill"]
    var texts = ["About", "Rate Lazybear", "Bug tracker", "Community"]
    var colours: [UIColor] = [.systemBlue, .systemRed, .systemYellow, .systemTeal]
}


struct Settings_Previews: PreviewProvider {
    static var previews: some View {
        return Settings()
    }
}
