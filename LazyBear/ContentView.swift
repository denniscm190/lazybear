//
//  ContentView.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 21/3/21.
//

import SwiftUI
import CoreHaptics

struct ContentView: View {
    @State private var showWelcome = false
    @State var selectedTab: Tab = .home
    
    @Environment(\.managedObjectContext) private var moc
    @FetchRequest(entity: WatchlistCompany.entity(), sortDescriptors: []) var watchlistCompanies: FetchedResults<WatchlistCompany>
    
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
        .onAppear(perform: onAppear)
        .sheet(isPresented: $showWelcome) {
            
        }
    }
    
    /*
     1) Create default watchlist if it doesn't exits
     2) Show WelcomeView if is the first time that the app is opened
     3) Prepare haptics
     */
    private func onAppear() {
        // Create watchlist
        if watchlistCompanies.isEmpty {
            let defaultCompanies: [DefaultCompanyModel] = parseJSON("DefaultCompanies.json")
            for defaultCompany in defaultCompanies {
                let watchlistCompany = WatchlistCompany(context: moc)
                watchlistCompany.name = defaultCompany.name
                watchlistCompany.symbol = defaultCompany.symbol
                watchlistCompany.watchlistName = "Default watchlist"
            }
            
            do {
                try moc.save()
                print("Default watchlist created")
            } catch {
                print(error.localizedDescription)
            }
        }
        
        // Show WelcomeView if is the first time that the app is opened
//        let defaults = UserDefaults.standard
//
//        if let isAppAlreadyLaunchedOnce = defaults.string(forKey: "IsAppAlreadyLaunchedOnce") {
//            print("App already launched : \(isAppAlreadyLaunchedOnce)")
//            self.showWelcome = true
//        }
        
        // Prepare haptics
//        hapticsManager.prepareHaptics()
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
