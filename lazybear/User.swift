//
//  User.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 27/12/20.
//

import SwiftUI

struct User: View {
    @Environment(\.presentationMode) var userPresentation
    @State var searchedCompany: String = ""
    @State public var showingSearch: Bool = false  // Search Bar
    
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(entity: FavCompany.entity(), sortDescriptors: [])
    var favCompanies: FetchedResults<FavCompany>
    
    var body: some View {
        NavigationView {
            VStack(alignment:.leading) {
                SearchBar(searchedText: $searchedCompany, placeholder: "Add a company ...", showingSearch: $showingSearch, exitButton: "Done")
                if showingSearch == false {
                    // Display favourites
                    List {
                        ForEach(favCompanies) { favCompany in
                            HStack {
                                Text(favCompany.name.capitalized)

                            }.padding()
                        }
                        // Delete from persistent storage
                        .onDelete { indexSet in
                            for index in indexSet {
                                viewContext.delete(favCompanies[index])
                            }
                            do {
                                try viewContext.save()
                                print("Company deleted")
                            } catch {
                                print(error.localizedDescription)
                            }
                        }
                    }
                }
                else {
                    if searchedCompany.count > 2 {
                        Spacer()
                        List {
                            ForEach(companiesData.filter({ searchedCompany.isEmpty ? true : $0.name.localizedStandardContains(searchedCompany) }), id: \.cik) { company in
                                FavCompanyRow(company: company)
                            }
                        }
                        .edgesIgnoringSafeArea(.bottom)
                        .cornerRadius(20)
                        .id(UUID())  // Increase speed in search the list
                    }
                    Spacer()
                }
            }
            .padding()
            .navigationTitle("My watchlist")
            .navigationBarItems(leading:
                Button(action: {self.userPresentation.wrappedValue.dismiss()}) {
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
