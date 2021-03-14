//
//  Settings.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 19/2/21.
//

import SwiftUI
import CoreData

struct Settings: View {
    let setting = SettingMetadata()
    @FetchRequest(entity: UserSettings.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \UserSettings.changedAt, ascending: false)])
    var userSettings: FetchedResults<UserSettings>
    @Environment(\.colorScheme) var colorScheme  // Detect dark mode
    @State private var showingSafari = false
    
    var body: some View {
        NavigationView {
            Form {
                ThemePicker(theme: userSettings.first?.theme ?? "Default")
                LanguagePicker(language: userSettings.first?.newsLanguage ?? "en")
                NavigationLink(destination: IconPicker()) {
                    Text("App icon")
                }
                
                Section(footer: IexAttribution(text: "Data provided by IEX Cloud").padding(.top)) {
                    ForEach((0...3), id: \.self) { index in
                            Button(action: { self.showingSafari = true }) {
                                HStack {
                                    SettingRow(image: setting.images[index], text: setting.texts[index], colour: setting.colours[index])
                                    FakeLinkArrow()
                                }
                            }
                            .foregroundColor(colorScheme == .dark ? .white: .black)
                            .sheet(isPresented: $showingSafari) {
                                SafariView(url:URL(string: setting.links[index])!)
                            }
                        
                    }
                }
            }
            .navigationTitle("Settings 👨🏻‍🔧")
        }
        .navigationViewStyle(StackNavigationViewStyle())
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
                 "https://apps.apple.com/us/app/lazybear/id1534612943",
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
