//
//  CompanyList.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 15/1/21.
//

import SwiftUI

struct CompanyList: View {
    @Binding var searchedCompany: String
    @State var isCoreData: Bool
    
    var body: some View {
        List {
            ForEach(companiesData.filter({ searchedCompany.isEmpty ? true : $0.name.localizedStandardContains(searchedCompany) }), id: \.cik) { company in
                if isCoreData {
                    FavCompanyRow(company: company)
                }
                else {
                    CompanyRow(company: company)
                }
            }
        }
        .edgesIgnoringSafeArea(.bottom)
        .cornerRadius(20)
        .id(UUID())  // Increase speed in search the list
    }
}

struct CompanyList_Previews: PreviewProvider {
    static var previews: some View {
        CompanyList(searchedCompany: .constant("Apple"), isCoreData: false)
    }
}
