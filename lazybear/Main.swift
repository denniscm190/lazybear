//
//  Main.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 12/1/21.
//

import SwiftUI

struct Main: View {
    @State var searchedCompany: String = ""  // Search bar
    @State public var showingSearch: Bool = false  // Search bar
    @State var showingSettings = false  // View sheet
    @State var showingUser = false  // View sheet
    @Environment(\.managedObjectContext) private var viewContext  // Core data
    
    var body: some View {
        VStack {
            if showingSearch == false {
                // Setting and user icons
                HStack {
                    Button(action: { self.showingSettings.toggle() }) {
                        Image(systemName: "gear")
                            .imageIconModifier()
                        
                    }.sheet(isPresented: $showingSettings) {
                        About()
                        
                    }

                    Spacer()
                    Button(action: { self.showingUser.toggle() }) {
                        Image(systemName: "person")
                            .imageIconModifier()
                        
                    }
                    .sheet(isPresented: $showingUser) {
                        User()
                            .environment(\.managedObjectContext, self.viewContext)
                        
                    }
                }
                .padding()
            }
            
            SearchBar(searchedText: $searchedCompany, placeholder: "Search ...", showingSearch: $showingSearch, exitButton: "Cancel")
            if showingSearch == false {
                Companies()
                    .transition(.move(edge: .bottom))
                    .animation(.default)
            }
            else {
                if searchedCompany.count > 2 {
                    CompanyList(searchedCompany: $searchedCompany, isCoreData: false)
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
