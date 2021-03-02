//
//  NewsLanguagePicker.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 26/2/21.
//

import SwiftUI

struct NewsLanguagePicker: View {
    @Environment(\.managedObjectContext) private var moc
    @State var language: String
    
    var body: some View {
        Picker("News language", selection: $language) {
            ForEach(newsLanguages, id: \.code) { language in
                Text("\(language.flag) \(language.name)")
                    .tag(language.code)
            }
        }
        .onChange(of: language, perform: { language in
            save(change: language)
        })
    }
    
    private func save(change: Any) {
        let userSettings = UserSettings(context: moc)
        userSettings.changedAt = Date()
        userSettings.newsLanguage = change as? String
        do {
            try moc.save()
            print("Settings saved")
        } catch {
            print(error.localizedDescription)
        }
    }
}

struct NewsLanguagePicker_Previews: PreviewProvider {
    static var previews: some View {
        NewsLanguagePicker(language: "en")
    }
}
