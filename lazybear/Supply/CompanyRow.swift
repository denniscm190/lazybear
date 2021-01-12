//
//  CompanyRown.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 31/12/20.
//

import SwiftUI

struct CompanyRow: View {
    var company: CompanyData
    
    var body: some View {
        HStack {
            NavigationLink(destination: Company(cik: company.cik, symbol: company.symbol, name: company.name)
                            .navigationBarTitle(company.name.capitalized)
            ) {
                Text(company.name.capitalized)
            }
        }
    }
}

struct CompanyRown_Previews: PreviewProvider {
    static var previews: some View {
        CompanyRow(company: companiesData[0])
    }
}
