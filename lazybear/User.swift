//
//  User.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 27/12/20.
//

import SwiftUI

struct User: View {
    @Environment(\.presentationMode) var userPresentation  // Dismiss sheet
    @State var searchedCompany: String = ""  // Search bar
    @State public var showingSearch: Bool = false  // Search Bar
    
    var body: some View {
        NavigationView {
            VStack(alignment:.leading) {
                SearchBar(searchedText: $searchedCompany, placeholder: "Add a company ...", showingSearch: $showingSearch, exitButton: "Done")
                if showingSearch == false {
                    FavCompanies()
                    }
                else {
                    if searchedCompany.count > 2 {
                        CompanyList(searchedCompany: $searchedCompany, isCoreData: true)
                    }
                    Spacer()
                }
            }
            .padding()
            .navigationTitle("My watchlist")
            .navigationBarItems(leading:
                Button(action: { self.userPresentation.wrappedValue.dismiss() }) {
                    Image(systemName: "multiply")
                        .resizable()
                        .frame(width: 25, height: 25)
                    
                }
            )
        }
    }
}

struct User_Previews: PreviewProvider {
    static var previews: some View {
       User()
    }
}
