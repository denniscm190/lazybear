//
//  WatchlistManagerTest.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 24/4/21.
//

import SwiftUI

/*
 DELETE IN PRODUCTION
 */

struct WatchlistManagerTest: View {
    @Environment(\.managedObjectContext) private var moc
    @FetchRequest(entity: WatchlistCompany.entity(), sortDescriptors: [])
    var watchlistCompany: FetchedResults<WatchlistCompany>
    
    var body: some View {
        VStack {
            Button("Add company", action: addCompany)
            Button("Reset Entity", action: resetCoreDataEntity)
        }
    }
    
//    private func removeCompany(at offsets: IndexSet) {
//        for index in offsets {
//            let company = companies[index]
//            moc.delete(company)
//        }
//        do {
//            try moc.save()
//        } catch {
//            // Error
//        }
//    }
    
    // Add to watchlist
    private func addCompany() {
        let watchlistCompany = WatchlistCompany(context: moc)
        watchlistCompany.symbol = "TSLA"
        watchlistCompany.name = "Tesla Inc"
        watchlistCompany.watchlist = "My portfolio"
        do {
            try moc.save()
            print("Company saved")
        } catch {
            print(error.localizedDescription)
        }
    }
    
//    private func removeCompany() {
//        let symbols = companies.map { $0.symbol }
//        let index = symbols.firstIndex(of: symbol)
//        let company = companies[index!]
//        moc.delete(company)
//        do {
//            try moc.save()
//            print("Company deleted")
//        } catch {
//            // Error
//        }
//    }
    
    private func resetCoreDataEntity() {
        for item in watchlistCompany {
            moc.delete(item)
        }
        do {
            try moc.save()
            print("Company deleted")
        } catch {
            // Error
        }
    }
}

struct WatchlistManagerTest_Previews: PreviewProvider {
    static var previews: some View {
        WatchlistManagerTest()
    }
}
