//
//  NewsList.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 21/6/21.
//

import SwiftUI

struct NewsList: View {
    var latestNews: [LatestNewsModel]
    @Environment(\.presentationMode) private var newsListPresentation
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    ForEach(latestNews, id: \.self) { new in
                        if !new.headline.isEmpty {
                            NewsRow(new: new)
                            Divider()
                                .padding(.leading, 80)
                            
                        }
                    }
                }
                .padding()
            }
            .navigationTitle("Latest news")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button(action: { newsListPresentation.wrappedValue.dismiss() }) {
                        Image(systemName: "multiply")
                    }
                }
            }
        }
    }
}

struct NewsList_Previews: PreviewProvider {
    static var previews: some View {
        NewsList(
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
