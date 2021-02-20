//
//  TestSearchAPI.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 20/2/21.
//

import SwiftUI

struct TestSearchAPI: View {
    @State private var companies = [CompanyModel]()
    
    var body: some View {
        Button(action: { print(companies) }) {
            Text("Print companies")
        }
        .onAppear {
            request(url: getUrl(), model: [CompanyModel].self) { self.companies = $0 }
        }
    }
    
    private func getUrl() -> String {
        let baseUrl = Bundle.main.infoDictionary?["IEX_URL"] as? String ?? "Empty url"
        let apiKey = Bundle.main.infoDictionary?["IEX_API"] as? String ?? "Empty key"
        let url = "\(baseUrl)/search/apple?token=\(apiKey)"
        
        return url
    }
}

struct TestSearchAPI_Previews: PreviewProvider {
    static var previews: some View {
        TestSearchAPI()
    }
}
