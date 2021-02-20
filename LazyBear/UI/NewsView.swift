//
//  NewsView.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 20/2/21.
//

import SwiftUI

struct NewsView: View {
    @State var news = [NewsModel]()
    var symbol: String
    
    var body: some View {
        VStack(alignment: .leading) {
            ForEach(news, id: \.self) { new in
                NewsRow(new: new)
                Divider()
            }
        }
        .onAppear {
            request(url: getUrl(), model: [NewsModel].self) { self.news = $0 }
        }
    }
    
    private func getUrl() -> String {
        let baseUrl = Bundle.main.infoDictionary?["IEX_URL"] as? String ?? "Empty url"
        let apiKey = Bundle.main.infoDictionary?["IEX_API"] as? String ?? "Empty key"
        let url = "\(baseUrl)/stock/\(symbol)/news/last/10?token=\(apiKey)"

        return url
    }
}


struct NewsView_Previews: PreviewProvider {
    static var previews: some View {
        NewsView(symbol: "aapl")
    }
}
