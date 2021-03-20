//
//  NewsView.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 20/2/21.
//

import SwiftUI
import WaterfallGrid

struct NewsView: View {
    var symbol: String
    @FetchRequest(entity: UserSettings.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \UserSettings.changedAt, ascending: false)])
    var userSettings: FetchedResults<UserSettings>
    @State private var news = [NewsModel]()
    
    var body: some View {
        VStack(alignment: .leading) {
            if !news.isEmpty {
                HStack {
                    Text("Recent news")
                        .font(.title)
                        .fontWeight(.semibold)
                    
                    Spacer()
                }
                .padding()
            }
            
            let language = userSettings.first?.newsLanguage ?? "en"
            let filteredNews = news.filter { $0.lang == language }
            
            // If iPhone
            if UIDevice.current.userInterfaceIdiom == .phone {
                ForEach(filteredNews, id: \.self) { new in
                    NewsRow(new: new)
                      .padding(.horizontal)
                    
                    Divider()
                    
                }
            }
            
            // If iPad
            if UIDevice.current.userInterfaceIdiom == .pad {
                WaterfallGrid(filteredNews, id: \.self) { new in
                    NewsRow(new: new)
                }
                .gridStyle(
                    columnsInPortrait: 2,
                    columnsInLandscape: 3,
                    spacing: 8,
                    animation: .easeInOut
                  )
                .padding(EdgeInsets(top: 16, leading: 8, bottom: 16, trailing: 8))
            }
        }
        .onAppear {
            let url = getUrl(endpoint: .news, symbol: symbol)
            request(url: url, model: [NewsModel].self) { self.news = $0 }
        }
    }
}


struct NewsView_Previews: PreviewProvider {
    static var previews: some View {
        NewsView(symbol: "aapl")
    }
}
