//
//  NewsRow.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 15/5/21.
//

import SwiftUI

struct NewsRow: View {
    var new: LatestNewsModel
    @State private var showingSafariView = false
    
    var body: some View {
        Button(action: { showingSafariView = true }) {
            VStack(alignment: .leading) {
                Text(new.source.uppercased())
                    .font(.caption)
                    .opacity(0.5)
                
                Text(new.headline)
                    .font(.headline)
                
                Text(new.summary)
                    .opacity(0.5)
                    .font(.subheadline)
                    .lineLimit(1)
                    .padding(.bottom, 5)
                
                let humanDate = convertDate()
                Text("\(humanDate) ago")
                    .font(.caption2)
                    .opacity(0.5)
                
                Divider()
            }
        }
        .buttonStyle(PlainButtonStyle())
        .sheet(isPresented: $showingSafariView) {
            SFSafariViewWrapper(url: URL(string: new.url)!)
        }
    }
    
    /*
     Convert Epoch time to human readable
     */
    private func convertDate() -> String {
        let now = Date() // Current date
        // Time when the article was published. Divide new.datetime by 1,000 because
        // TimeInterval() function must be in seconds, not in miliseconds
        let articlePublished = Date(timeIntervalSince1970: TimeInterval(new.datetime)/1000)
        let formatter = DateComponentsFormatter()
        formatter.unitsStyle = .full
        let humanDate = formatter.string(from: articlePublished, to: now)!
        
        return humanDate
    }
}

struct NewsRow_Previews: PreviewProvider {
    static var previews: some View {
        NewsRow(new: LatestNewsModel(
                datetime: 1621037430000,
                headline: "Chaos Monkeys' author calls Apple's statement on his departure defamatory",
                image: "https://cloud.iexapis.com/v1/news/image/99abeb99-6d9e-47c8-ae7b-53404eacccec",
                source: "Investing.com",
                summary: "https://www.investing.com/news/stock-market-news",
                url: "https://cloud.iexapis.com/v1/news/article/99abeb99-6d9e-47c8-ae7b-53404eacccec"))
    }
}
