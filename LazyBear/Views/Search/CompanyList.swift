//
//  CompanyList.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 3/4/21.
//

import SwiftUI

struct CompanyList: View {
    var searchResult: [SearchResponse]
    
    // Only unseful when it's called from Profile View
    var calledFromProfileView: Bool?
    var newWatchlistClass: NewWatchlistClass?
    @Binding var presentationMode: PresentationMode
    
    var body: some View {
        List(searchResult, id: \.self) { company in
            SearchedCompanyItem(company: company, calledFromProfileView: calledFromProfileView)
                .if(calledFromProfileView ?? false ) { content in
                    Button(action: { save(company) }) {
                        content
                    }
                }
        }
    }
    
    private func save(_ company: SearchResponse) {
        newWatchlistClass!.companies.append(company)
        $presentationMode.wrappedValue.dismiss()  // Dismiss view
    }
}

/*
 Wrap view on condition
 */
extension View {
   @ViewBuilder
   func `if`<Content: View>(_ conditional: Bool, content: (Self) -> Content) -> some View {
        if conditional {
            content(self)
        } else {
            NavigationLink(destination: Text("Hello")) {
                self
            }
        }
    }
}

struct CompanyList_Previews: PreviewProvider {
    @Environment(\.presentationMode) static var presentationMode
    
    static var previews: some View {
        CompanyList(searchResult: [SearchResponse(currency: "USD", region: "US", securityName: "aaple inc", symbol: "aapl"), SearchResponse(currency: "USD", region: "US", securityName: "aaple inc", symbol: "aapl"), SearchResponse(currency: "USD", region: "US", securityName: "aaple inc", symbol: "aapl"), SearchResponse(currency: "USD", region: "US", securityName: "aaple inc", symbol: "aapl"), SearchResponse(currency: "USD", region: "US", securityName: "aaple inc", symbol: "aapl")], presentationMode: presentationMode)
    }
}
