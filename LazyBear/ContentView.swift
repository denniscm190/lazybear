//
//  ContentView.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 21/3/21.
//

import SwiftUI

struct ContentView: View {
    @State private var showWelcome = false
    @State var selectedTab: Tab = .home
    @StateObject var hapticsManager = HapticsManager()
    
    @Environment(\.managedObjectContext) private var moc
    @FetchRequest(entity: WatchlistCompany.entity(), sortDescriptors: [])
    var watchlistCompanies: FetchedResults<WatchlistCompany>
    
    var body: some View {
        TabView(selection: $selectedTab) {
            HomeView()
                .tabItem {
                    Image(systemName: "house")
                    Text("Home")
                }
                .tag(Tab.home)  /// Do not remove tags. It causes an odd behaviour when showView is activated
            SearchView()
                .tabItem {
                    Image(systemName: "magnifyingglass")
                    Text("Search")
                }
                .tag(Tab.search)
            ProfileView()
                .tabItem {
                    Image(systemName: "person")
                    Text("Profile")
                }
                .tag(Tab.profile)
        }
        .onAppear {
//            isAppAlreadyLaunchedOnce()
            hapticsManager.prepareHaptics()
            createDefaultWatchlist()
        }
        .sheet(isPresented: $showWelcome) {
            
        }
    }
    
    /*
     Check if app is already launched one -> If not show welcome
     */
//    private func isAppAlreadyLaunchedOnce() {
//        let defaults = UserDefaults.standard
//
//        if let isAppAlreadyLaunchedOnce = defaults.string(forKey: "IsAppAlreadyLaunchedOnce") {
//            print("App already launched : \(isAppAlreadyLaunchedOnce)")
//            self.showWelcome = true
//        }
//    }
    
    /*
     Check if exist default watchlist (Core Data) -> if not, create it
     */
    private func createDefaultWatchlist() {
        let defaultCompanies = [("TSLA", "Tesla Inc"), ("AAPL", "Apple Inc"), ("MSFT", "Microsoft Corporation"), ("GS", "Goldman Sachs Group, Inc.")]
        if watchlistCompanies.isEmpty {
            for tupleCompany in defaultCompanies {
                let watchlistCompany = WatchlistCompany(context: moc)
                watchlistCompany.symbol = tupleCompany.0
                watchlistCompany.name = tupleCompany.1
                watchlistCompany.watchlistName = "Default watchlist"
            }
            do {
                try moc.save()
                print("Default watchlist created")
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}
extension ContentView {
    enum Tab: Hashable {
        case home
        case search
        case profile
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
