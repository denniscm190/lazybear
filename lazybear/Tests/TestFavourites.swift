//
//  TestFavourites.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 12/1/21.
//

import SwiftUI

struct TestFavourites: View {
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(entity: Favourite.entity(), sortDescriptors: [])
    var favourites: FetchedResults<Favourite>
    
    var body: some View {
        VStack {
            // Add to favourite
            Button(action: { addFavourite() }) {
                Text("Add to favourite")
            }
            
            // Display favourites
            List {
                ForEach(favourites) { favourite in
                    HStack {
                        Text(String(favourite.cik))
                        Spacer()
                        Text(String(favourite.isFavourite))
                        // Update cik -> I could use that to update bool
                        Spacer()
                        Button(action: { updateFavourite(favourite: favourite) }) {
                            Text("Update bool")
                                .foregroundColor(.blue)
                        }
                    }.padding()
                }
                // Delete from persistent storage
                .onDelete { indexSet in
                    for index in indexSet {
                        viewContext.delete(favourites[index])
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
        let favourite = Favourite(context: viewContext)
        favourite.cik = 12345
        favourite.isFavourite = true
        do {
            try viewContext.save()
            print("Company saved.")
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func updateFavourite(favourite: Favourite) {
        let newStatus = false
        viewContext.performAndWait {
            favourite.isFavourite = newStatus
            try? viewContext.save()
            print("Company updated")
        }
    }
}

struct TestFavourites_Previews: PreviewProvider {
    static var previews: some View {
        TestFavourites()
    }
}
