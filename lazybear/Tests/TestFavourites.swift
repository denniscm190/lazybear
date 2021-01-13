//
//  TestFavourites.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 12/1/21.
//
/*
import SwiftUI

struct TestFavourites: View {
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(entity: FavCompany.entity(), sortDescriptors: [])
    var favCompanies: FetchedResults<FavCompany>
    
    var body: some View {
        VStack {
            // Add to favourite
            Button(action: { addFavourite() }) {
                Text("Add to favourite")
            }
            
            // Display favourites
            List {
                ForEach(favCompanies) { favCompany in
                    HStack {
                        Text(String(favCompany.cik))
                        Text(favCompany.symbol)
                        Text(favCompany.name)

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
    }
    
    func addFavourite() {
        let favCompany = FavCompany(context: viewContext)
        favCompany.cik = 12345
        favCompany.symbol = "AAPL"
        favCompany.name = "Apple Inc"
        do {
            try viewContext.save()
            print("Company saved.")
        } catch {
            print(error.localizedDescription)
        }
    }
    /*
    func updateFavourite(favCompany: FavCompany) {
        let newStatus = false
        viewContext.performAndWait {
            favCompany.cik = newStatus
            try? viewContext.save()
            print("Company updated")
        }
    }
     */
}

struct TestFavourites_Previews: PreviewProvider {
    static var previews: some View {
        TestFavourites()
    }
}
*/
