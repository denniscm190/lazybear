//
//  Search.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 19/2/21.
//

import SwiftUI
import SwiftlySearch

struct Search: View {
    @State private var company = String()
    @State private var companies = [CompanyModel]()
    
    var body: some View {
        NavigationView {
            List(companies, id: \.symbol) { company in
                Row(baseText: company.symbol ?? "-", subText: company.securityName ?? "")
            }
            .navigationBarSearch(self.$company)
                .onChange(of: company, perform: { company in
                    request(url: getUrl(), model: [CompanyModel].self) { self.companies = $0 }
                })
            .navigationTitle("Search 🔍")
        }
    }
    
    private func getUrl() -> String {
        let baseUrl = Bundle.main.infoDictionary?["IEX_URL"] as? String ?? "Empty url"
        let apiKey = Bundle.main.infoDictionary?["IEX_API"] as? String ?? "Empty key"
        let url = "\(baseUrl)/search/\(company)?token=\(apiKey)"
        
        return url
    }
}

struct Search_Previews: PreviewProvider {
    static var previews: some View {
        Search()
    }
}
