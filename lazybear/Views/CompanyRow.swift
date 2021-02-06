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
    
    @EnvironmentObject var apiAccess: ApiAccess  // Env apis info
    let persistenceController = PersistenceController.shared // Core Data
    
    var body: some View {
        let name = company?.name ?? history?.name ?? ""
        let symbol = company?.symbol ?? history?.symbol ?? ""
        
        NavigationLink(destination: Company(name: name, symbol: symbol)
                        .environment(\.managedObjectContext, persistenceController.container.viewContext)
                        .environmentObject(apiAccess)  // Api info (url and token)
        ) {
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
