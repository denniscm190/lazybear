//
//  CompanyRown.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 31/12/20.
//

import SwiftUI

struct CompanyRow: View {
    var company: CompanyModel?
    var history: RecentSearch?
    @State var showingCompany = false
    
    var body: some View {
        let name = company?.name ?? history?.name ?? ""
        let symbol = company?.symbol ?? history?.symbol ?? ""
        
        NavigationLink(destination: Company(name: name, symbol: symbol)) {
            VStack(alignment: .leading) {
                Text(symbol.uppercased())
                    .fontWeight(.semibold)
                
                Text(name.capitalized)
                    .font(.subheadline)
            }
        }
    }
}

struct CompanyRown_Previews: PreviewProvider {
    static var previews: some View {
        CompanyRow(company: companiesData[0])
    }
}
