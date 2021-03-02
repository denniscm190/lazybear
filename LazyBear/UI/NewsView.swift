//
//  NewsView.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 20/2/21.
//

import SwiftUI

struct NewsView: View {
    var symbol: String
    @FetchRequest(entity: UserSettings.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \UserSettings.changedAt, ascending: false)]) var userSettings: FetchedResults<UserSettings>
    @State private var news = [NewsModel]()
    
    var body: some View {
        VStack(alignment: .leading) {
            let language = userSettings.first?.newsLanguage ?? "en"
            ForEach(news, id: \.self) { new in
                if language == new.lang {
                    NewsRow(new: new)
                    Divider()
                }
            }
        }
        .onAppear {
            request(url: getUrl(), model: [NewsModel].self) { self.news = $0 }
        }
    }
    
    private func getUrl() -> String {
        let baseUrl = Bundle.main.infoDictionary?["IEX_URL"] as? String ?? "Empty url"
        let apiKey = Bundle.main.infoDictionary?["IEX_API"] as? String ?? "Empty key"
        let url = "\(baseUrl)/stock/\(symbol)/news/last/30?token=\(apiKey)"

        return url
    }
}


struct NewsView_Previews: PreviewProvider {
    static var previews: some View {
        NewsView(symbol: "aapl")
    }
}
