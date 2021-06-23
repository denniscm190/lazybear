//
//  NewsHelper.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 21/6/21.
//

import SwiftUI

struct NewsHelper: View {
    var latestNews: [LatestNewsModel]
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("Latest news")
                    .font(.title)
                    .fontWeight(.semibold)
                
                Spacer()

                NavigationLink(destination: NewsList(latestNews: latestNews)
                                .navigationTitle("Latest news")
                ) {
                    Text("See all")
                        .accentColor(Color(.systemBlue))
                }
            }
            .padding(.bottom)
            
            let latestNewsPrefixed = latestNews.prefix(4)
            ForEach(latestNewsPrefixed, id: \.self) { new in
                if !new.headline.isEmpty {
                    NewsRow(new: new)
                    Divider()
                }
            }
        }
        .padding()
        .background(
            CustomRectangleBox()
        )
    }
}

struct NewsHelper_Previews: PreviewProvider {
    static var previews: some View {
        NewsHelper(
            latestNews: [
                LatestNewsModel(
                    datetime: 1621037430000,
                    headline: "Chaos Monkeys' author calls Apple's statement on his departure defamatory",
                    image: "https://cloud.iexapis.com/v1/news/image/99abeb99-6d9e-47c8-ae7b-53404eacccec",
                    source: "Investing.com",
                    summary: "https://www.investing.com/news/stock-market-news",
                    url: "https://cloud.iexapis.com/v1/news/article/99abeb99-6d9e-47c8-ae7b-53404eacccec")
            ]
        )
    }
}
