//
//  News.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 4/2/21.
//

import SwiftUI

struct News: View {
    var symbol: String
    @EnvironmentObject var apiAccess: ApiAccess
    
    // <--------- API Job --------->
    @State private var url = String() {
        didSet { request(url: url, model: [NewsModel].self) { self.news = $0 } }}
    
    @State private var news = [NewsModel]()
    // <--------- API Job --------->
    
    var body: some View {
        Text("Business news")
            .font(.title)
            .fontWeight(.semibold)
            .padding([.leading, .top])
        
        Divider()
        
        VStack {
            ForEach(news, id: \.self) { new in
                NewsRow(new: new)
            }
        }
        .onAppear { getUrl() }
    }
    
    
    private func getUrl() {
        // 1 -> Sandbox / 2 -> Production
        let baseUrl = apiAccess.results[1].url ?? ""
        let token = apiAccess.results[1].key ?? ""
        let path = "/stable/stock/\(symbol)/news/last/10?token="
        
        self.url = baseUrl + path + token
    }
}

struct News_Previews: PreviewProvider {
    static var previews: some View {
        News(symbol: "aapl")
            .environmentObject(ApiAccess())
    }
}
