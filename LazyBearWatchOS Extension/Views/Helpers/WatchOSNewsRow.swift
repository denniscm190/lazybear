//
//  WatchOSNewsRow.swift
//  LazyBearWatchOS Extension
//
//  Created by Dennis Concepción Martín on 27/06/2021.
//

import SwiftUI

struct WatchOSNewsRow: View {
    var new: LatestNewsModel
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("\(convertEpoch(new.datetime, true)) ago")
                    .font(.footnote)
                    .opacity(0.5)
                
                Text(new.headline.capitalized)
                    .font(.headline)
                    .fontWeight(.semibold)
                    .fixedSize(horizontal: false, vertical: true)  /// I need to add this to make lineLimit works correctly
                    .lineLimit(3)
            }
        }
    }
}

struct WatchOSNewsRow_Previews: PreviewProvider {
    static var previews: some View {
        WatchOSNewsRow(
            new: LatestNewsModel(
                    datetime: 1621037,
                    headline: "Chaos Monkeys' author calls Apple's statement on his departure defamatory",
                    image: "https://cloud.iexapis.com/v1/news/image/99abeb99-6d9e-47c8-ae7b-53404eacccec",
                    source: "Investing.com",
                    summary: "https://www.investing.com/news/stock-market-news",
                    url: "https://bloomberg.com")
        )
    }
}
