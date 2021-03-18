//
//  ThemePicker.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 26/2/21.
//

import SwiftUI

struct ThemePicker: View {
    @Environment(\.managedObjectContext) private var moc
    @State var theme: String
    let haptics = Haptics()
    
    var body: some View {
        Picker("Themes", selection: $theme) {
            ForEach(themes, id: \.name) { theme in
                HStack {
                    RoundedRectangle(cornerRadius: 4)
                        .frame(width: 20, height: 20)
                        .foregroundColor(Color("\(theme.name.lowercased())Accent"))
                    
                    Text(theme.name)
                        .tag(theme.name)
                }
            }
        }
        .onChange(of: theme, perform: { theme in
            save(change: theme)
        })
    }
    
    private func save(change: Any) {
        let userSettings = UserSettings(context: moc)
        userSettings.changedAt = Date()
        userSettings.theme = change as? String
        do {
            try moc.save()
            haptics.simpleSuccess()
            print("Settings saved")
        } catch {
            print(error.localizedDescription)
        }
    }
}

struct ThemePicker_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            Form {
                ThemePicker(theme: "Default")
            }
            .navigationBarHidden(true)
        }
    }
}
