//
//  Search.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 19/2/21.
//

import SwiftUI

struct Search: View {
    @State private var company = String()
    
    var body: some View {
        NavigationView {
            VStack {
                SearchBar(searchedText: $company)
                    List(companies.filter({company.isEmpty ? false : $0.name.localizedStandardContains(company)}),id: \.symbol) { company in
                        Row(baseText: company.symbol, subText: company.name)
                    }
                    .id(UUID())
            }
            .navigationTitle("Search 🔍")
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct Search_Previews: PreviewProvider {
    static var previews: some View {
        Search()
    }
}
