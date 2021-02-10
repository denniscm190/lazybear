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
        List {
            //Filter list 
            ForEach(companiesData.filter({ searchedCompany.isEmpty ? true : $0.name.localizedStandardContains(searchedCompany) })
                    , id: \.symbol) { company in
                    CompanyRow(companyModel: company)
            }
        } .id(UUID())  // Increase list speed when searching
    }
}

struct CompanyList_Previews: PreviewProvider {
    static var previews: some View {
        //NavigationView {
            CompanyList(searchedCompany: "apple inc")
                .environmentObject(ApiManager())
        //}
    }
}
