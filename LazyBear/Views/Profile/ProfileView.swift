//
//  ProfileView.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 4/4/21.
//

import SwiftUI

//struct ProfileView: View {
//    @ObservedObject var profileData = ProfileData()
//    @Environment(\.managedObjectContext) private var moc
//    @FetchRequest(entity: WatchlistCompany.entity(), sortDescriptors: [])
//    var watchlistCompanies: FetchedResults<WatchlistCompany>
//    
//    var body: some View {
//        NavigationView {
//            List {
//                Text("Hello World")
//                Button("Save company", action: addCompany)
//                Button("Delete company", action: removeCompany)
//                Button("Request", action: {profileData.get(watchlistCompanies)})
//                Button("Print watchlist", action: {print(watchlistCompanies.map {$0.symbol})})
//            }
//            .navigationTitle("My profile")
//            .navigationBarTitleDisplayMode(.inline)
//        }
//    }
//    
//    // REMOVE IN PRODUCTION
//    private func addCompany() {
//        let watchlistCompany = WatchlistCompany(context: moc)
//        watchlistCompany.symbol = "FB"
//        watchlistCompany.name = "Facebook Inc"
//        watchlistCompany.watchlist = "MyWatchlist"
//        do {
//            try moc.save()
//            print("Company saved")
//        } catch {
//            print(error.localizedDescription)
//        }
//    }
//    
//    private func removeCompany() {
//        let symbols = watchlistCompanies.map { $0.symbol }
//        let index = symbols.firstIndex(of: "aapl")
//        let company = watchlistCompanies[index!]
//        moc.delete(company)
//        do {
//            try moc.save()
//            print("Company deleted")
//        } catch {
//            // Error
//        }
//    }
//}
//
//struct ProfileView_Previews: PreviewProvider {
//    static var previews: some View {
//        ProfileView()
//    }
//}
