//
//  Main.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 12/1/21.
//

import SwiftUI

struct Main: View {
    @State var searchedCompany: String = ""
    @State var showingSettings = false
    @State var showingUser = false
    @State public var showingSearch: Bool = false  // Search Bar
    
    var body: some View {
        VStack {
            if showingSearch == false {
                // Setting and user
                HStack {
                    Button(action: {self.showingSettings.toggle()}
                    ) {
                        Image(systemName: "gear")
                            .imageIconModifier()
                    }.sheet(isPresented: $showingSettings) {
                        About()
                    }
                    
                    Spacer()
                    Button(action: {self.showingUser.toggle()
                    }) {
                        Image(systemName: "person")
                            .imageIconModifier()
                    }.sheet(isPresented: $showingUser) {
                        User()
                    }
                }
                .transition(.move(edge: .top))
                .animation(.default)
                .padding()
            }
            
            SearchBar(searchedText: $searchedCompany, placeholder: "Search ...", showingSearch: $showingSearch, exitButton: "Cancel")
            
            if showingSearch == false {
                Companies()
                    .transition(.move(edge: .bottom))
                    .animation(.default)
                
            } else {
                if searchedCompany.count > 2 {
                    Spacer()
                    List {
                        ForEach(companiesData.filter({ searchedCompany.isEmpty ? true : $0.name.localizedStandardContains(searchedCompany) }), id: \.cik) { company in
                            CompanyRow(company: company)
                        }
                    }
                    .edgesIgnoringSafeArea(.bottom)
                    .cornerRadius(20)
                    .id(UUID())  // Increase speed in search the list
                }
                Spacer()
            }
        }
        .navigationBarHidden(true)
    }
}
extension Image {
    func imageIconModifier() -> some View {
        self
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(maxWidth: 30)
    }
}


struct Main_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            Main()
                .navigationViewStyle(StackNavigationViewStyle())
        }
    }
}
