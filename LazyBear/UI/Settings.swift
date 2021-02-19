//
//  Settings.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 19/2/21.
//

import SwiftUI
import CoreData

struct Settings: View {
    @Environment(\.managedObjectContext) private var moc
    @FetchRequest(entity: UserSettings.entity(), sortDescriptors: []) var userSettings: FetchedResults<UserSettings>
    @State var theme = ""

    var body: some View {
        NavigationView {
            Form {
                Picker("Themes", selection: $theme) {
                    ForEach(themes, id: \.name) { theme in
                        Text(theme.name)
                            .tag(theme.name)
                    }
                }
                .onChange(of: theme, perform: { theme in
                    save(change: theme)
                })
            }
            .navigationTitle("Settings 👨🏻‍🔧")
        }
    }
    
    private func save(change: Any) {
        let userSettings = UserSettings(context: moc)
        userSettings.theme = change as! String
        do {
            try moc.save()
            print("Core Data saved")
        } catch {
            print(error.localizedDescription)
        }
    }
}


struct Settings_Previews: PreviewProvider {
    static var previews: some View {
        return Settings()
    }
}
