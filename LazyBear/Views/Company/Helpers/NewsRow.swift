//
//  NewsRow.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 21/6/21.
//

import SwiftUI
import SDWebImageSwiftUI

struct NewsRow: View {
    var new: LatestNewsModel
    @State private var showWebArticle = false
    
    var body: some View {
        HStack {
            RoundedRectangle(cornerRadius: 10)
                .frame(width: 65, height: 65, alignment: .center)
                .overlay(
                    WebImage(url: URL(string: new.image))
                       .resizable()
                       .placeholder {
                           Rectangle()
                            .foregroundColor(.gray)
                       }
                       .indicator(.activity)
                       .scaledToFill()
                    )
                .clipShape(RoundedRectangle(cornerRadius: 10))
            
            VStack(alignment: .leading) {
                Text(new.headline)
                    .font(.callout)
                    .fontWeight(.semibold)
                    .fixedSize(horizontal: false, vertical: true)  /// I need to add this to make lineLimit works correctly
                    .lineLimit(3)
            }
            .padding(.horizontal, 5)
            
            Button(action: { showWebArticle = true }) {
                Capsule()
                    .foregroundColor(Color(.secondarySystemBackground))
                    .frame(width: 80, height: 35, alignment: .center)
                    .overlay(
                        Text("READ")
                            .font(.headline)
                    )
            }
        }
        .sheet(isPresented: $showWebArticle) {
            SFSafariViewWrapper(url: URL(string: new.url)!)
                .edgesIgnoringSafeArea(.bottom)
        }
    }
}

struct NewsRow_Previews: PreviewProvider {
    static var previews: some View {
        NewsRow(
            new: LatestNewsModel(
                    datetime: 1621037430000,
                    headline: "Chaos Monkeys' author calls Apple's statement on his departure defamatory",
                    image: "https://cloud.iexapis.com/v1/news/image/99abeb99-6d9e-47c8-ae7b-53404eacccec",
                    source: "Investing.com",
                    summary: "https://www.investing.com/news/stock-market-news",
                    url: "https://bloomberg.com")
        )
    }
}
