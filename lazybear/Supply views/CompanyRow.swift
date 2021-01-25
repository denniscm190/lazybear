//
//  CompanyRown.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 31/12/20.
//

import SwiftUI

struct CompanyRow: View {
    @ObservedObject var companyView = CompanyView()
    var company: CompanyModel
    var favCompany: FavCompany
    
    var body: some View {
        Button(action: { companyView.isShowing.toggle() }) {
            VStack(alignment: .leading) {
                Text(company.symbol.uppercased())
                    .fontWeight(.semibold)
                
                Text(company.name.capitalized)
                    .font(.caption)
                
            }
        }
        .fullScreenCover(isPresented: $companyView.isShowing) {
            Company(name: company.name, symbol: company.symbol)
        }
    }
}

struct CompanyRown_Previews: PreviewProvider {
    static var previews: some View {
        CompanyRow(company: companiesData[0], favCompany: FavCompany.init())
    }
}
