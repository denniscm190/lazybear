//
//  News.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 4/2/21.
//

import SwiftUI

struct News: View {
    var symbol: String
    @EnvironmentObject var apiManager: ApiManager
    
    // API job variables
    @State private var url = String() {
        didSet { request(url: url, model: [NewsModel].self) { self.news = $0 } }}
    
    @State private var news = [NewsModel]()
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Business news")
                .font(.title)
                .fontWeight(.semibold)
                .padding([.leading, .top])
            
            Divider()
            ForEach(news, id: \.self) { new in
                NewsRow(new: new)
            }
        }
        .onAppear { getUrl() }
    }
    
    // Create endpoint
    private func getUrl() {
        let baseUrl = apiManager.results[apiManager.option].url ?? ""
        let token = apiManager.results[apiManager.option].key ?? ""
        let path = "/stable/stock/\(symbol)/news/last/10?token="
        
        self.url = baseUrl + path + token
    }
}

struct News_Previews: PreviewProvider {
    static var previews: some View {
        News(symbol: "aapl")
            .environmentObject(ApiManager())
    }
}
