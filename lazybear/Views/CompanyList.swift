//
//  CompanyList.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 7/2/21.
//

import SwiftUI

struct CompanyList: View {
    @State var searchedCompany: String
    
    var body: some View {
        ForEach(companiesData.filter({ searchedCompany.isEmpty ? true : $0.name.localizedStandardContains(searchedCompany) })
                , id: \.symbol) { company in
                CompanyRow(company: company)
            
        }
    }
}

struct CompanyList_Previews: PreviewProvider {
    static var previews: some View {
        //NavigationView {
            CompanyList(searchedCompany: "apple inc")
                .environmentObject(ApiAccess())
        //}
    }
}
