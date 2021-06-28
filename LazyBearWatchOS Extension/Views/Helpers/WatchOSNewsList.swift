//
//  WatchOSNewsList.swift
//  LazyBearWatchOS Extension
//
//  Created by Dennis Concepción Martín on 27/06/2021.
//

import SwiftUI

struct WatchOSNewsList: View {
    var latestNews: [LatestNewsModel]?
    
    var body: some View {
        VStack {
            if let latestNews = latestNews {
                List(latestNews, id: \.self) { new in
                    NavigationLink(destination: WatchOSNewsDetail(new: new)
                                    .navigationTitle("News")
                    ) {
                        WatchOSNewsRow(new: new)
                    }
                }
            } else {
                // Handle if there is no data
            }
        }
    }
}

struct WatchOSNewsList_Previews: PreviewProvider {
    static var previews: some View {
        WatchOSNewsList(
            latestNews: [
                LatestNewsModel(
                    datetime: 1621037430000,
                    headline: "Chaos Monkeys' author calls Apple's statement on his departure defamatory",
                    image: "https://cloud.iexapis.com/v1/news/image/99abeb99-6d9e-47c8-ae7b-53404eacccec",
                    source: "Investing.com",
                    summary: "https://www.investing.com/news/stock-market-news",
                    url: "https://bloomberg.com")
            ]
        )
    }
}
