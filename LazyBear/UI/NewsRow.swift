//
//  NewsRow.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 20/2/21.
//

import SwiftUI

struct NewsRow: View {
    var new: NewsModel
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                if let source = new.source {
                    Text(source.uppercased())
                        .font(.caption)
                        .opacity(0.5)
                    
                }
    
                if let headline = new.headline {
                    Text(headline)
                        .font(.headline)
                        .lineLimit(4)
                }
                
                if let summary = new.summary {
                    Text(summary)
                        .opacity(0.5)
                        .font(.subheadline)
                        .lineLimit(1)
                        .padding(.bottom, 5)
                }
                
                if (new.datetime != nil) {
                    let humanDate = convertDate()
                    Text("\(humanDate) ago")
                        .font(.caption2)
                        .opacity(0.5)
                }
                
                Text(new.lang ?? "Nil")
            }
        }
        .padding(.horizontal)
    }
    
    // Cover Epoch time to human date
        private func convertDate() -> String {
            let now = Date() // Current date
            // Time when the article was published. Divide new.datetime by 1,000 because
            // TimeInterval() function must be in seconds, not in miliseconds
            let articlePublished = Date(timeIntervalSince1970: TimeInterval(new.datetime ?? 0)/1000)
            let formatter = DateComponentsFormatter()
            formatter.unitsStyle = .full
            let humanDate = formatter.string(from: articlePublished, to: now)!
            
            return humanDate
        }
}

struct NewsRow_Previews: PreviewProvider {
    static var previews: some View {
        NewsRow(new: NewsModel(datetime: 1613838000000, headline: "As Facebook, Microsoft, Apple, Uber, Amazon, and others play larger roles in OpenStreetMap, hobbyists fear private sector will overshadow their work (Corey Dickinson/Bloomberg)", source: "Techmeme", url: "https://cloud.iexapis.com/v1/news/article/d760b0bc-42f0-4ed0-a721-a7691eeaa132", summary: "Corey Dickinson / Bloomberg : As Facebook, Microsoft, Apple, Uber, Amazon, and others play larger roles in OpenStreetMap, hobbyists fear private sector will overshadow their work — What do Lyft, Facebook, the International Red Cross, the U.N., the government of Nepal and Pokémon Go have in common?", image: "https://cloud.iexapis.com/v1/news/image/d760b0bc-42f0-4ed0-a721-a7691eeaa132"))
    }
}
