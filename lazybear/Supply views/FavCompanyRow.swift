//
//  FavCompanyRow.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 22/1/21.
//

import SwiftUI
/*
struct FavCompanyRow: View {
    var favCompany: FavCompany
    var index: Int
    @ObservedObject var showingCompany = ShowingCompany()
    let persistenceController = PersistenceController.shared
    
    var body: some View {
        Button(action: { showingCompany.isShowing.toggle() }) {
            HStack {
                Image(systemName: "building.2")
                    .foregroundColor(.white)
                    .padding(5)
                    .background(
                        randomColor(index: index)
                            .cornerRadius(5)
                    )
                
                VStack(alignment: .leading) {
                    Text(favCompany.symbol.uppercased())
                        .fontWeight(.semibold)
                    
                    Text(favCompany.name.capitalized)
                        .font(.caption)
                }
            }
        }
        .fullScreenCover(isPresented: $showingCompany.isShowing) {
            Company(name: favCompany.name, symbol: favCompany.symbol)
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
            
        }
    }
}

struct FavCompanyRow_Previews: PreviewProvider {
    static var previews: some View {
        FavCompanyRow(favCompany: FavCompany.init(), index: 0)
    }
}
*/
