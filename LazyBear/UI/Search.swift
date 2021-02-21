//
//  Search.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 19/2/21.
//

import SwiftUI
import SwiftlySearch

struct Search: View {
    @ObservedObject var hudManager: HUDManager
    @State private var company = String()
    @State private var companies = [CompanyModel]()
    
    var body: some View {
        NavigationView {
            List(filterList(), id: \.symbol) { company in
                NavigationLink(destination: CompanyView(hudManager: hudManager, name: company.securityName ?? "-", symbol: company.symbol)
                                .navigationTitle(company.symbol)
                ) {
                    CompanyRow(symbol: company.symbol, name: company.securityName ?? "-")
                }
            }
            .navigationBarSearch(self.$company)
                .onChange(of: company, perform: { company in
                    request(url: getUrl(), model: [CompanyModel].self) { self.companies = $0 }
                })
            .navigationTitle("Search 🔍")
        }
        // Empty list
        .onDisappear { self.companies = [CompanyModel]() }
    }
    
    private func getUrl() -> String {
        let baseUrl = Bundle.main.infoDictionary?["IEX_URL"] as? String ?? "Empty url"
        let apiKey = Bundle.main.infoDictionary?["IEX_API"] as? String ?? "Empty key"
        let encodedCompanyName = company.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        let url = "\(baseUrl)/search/\(encodedCompanyName!)?token=\(apiKey)"
        
        return url
    }
    
    private func filterList() -> [CompanyModel] {
        // Exclude symbols with "-" and numbers -> they are secondary stock symbols
        // of the same company but different market. Currently, not interested in them.
        let decimalCharacters = CharacterSet.decimalDigits
        let filteredCompanies = companies.filter {
            $0.symbol.rangeOfCharacter(from: decimalCharacters) == nil && // Exclude symbols with numbers
            !$0.symbol.contains("-")  // Exclude symbols with "-"
        }
        
        return filteredCompanies
    }
}

struct Search_Previews: PreviewProvider {
    static var previews: some View {
        Search(hudManager: HUDManager())
    }
}
