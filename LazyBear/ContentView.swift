//
//  ContentView.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 21/3/21.
//

import SwiftUI

struct ContentView: View {
    @State private var showWelcome = false
    @EnvironmentObject var hudManager: HudManager
    
    var body: some View {
        ZStack {
            TabView {
                HomeView()
                    .tabItem {
                        Image(systemName: "house")
                        Text("Home")
                    }
                SearchView()
                    .tabItem {
                        Image(systemName: "magnifyingglass")
                        Text("Search")
                    }
                ProfileView()
                    .tabItem {
                        Image(systemName: "person")
                        Text("Profile")
                    }
//                Text("The Last Tab")
//                    .tabItem {
//                        Image(systemName: "4.square.fill")
//                        Text("Forth")
//                    }
            }
    //        .onAppear { isAppAlreadyLaunchedOnce() }
            .sheet(isPresented: $showWelcome) {
                
            }
            
            Group {
                BackgroundShadow()
                    
                HelpSheet()
                    .offset(y: hudManager.showSearchHelper ? 0 : 700)
                    .padding(.horizontal)
            }
            .animation(.easeInOut)
        }
    }
    
//    private func isAppAlreadyLaunchedOnce() {
//        let defaults = UserDefaults.standard
//
//        if let isAppAlreadyLaunchedOnce = defaults.string(forKey: "IsAppAlreadyLaunchedOnce") {
//            print("App already launched : \(isAppAlreadyLaunchedOnce)")
//            self.showWelcome = true
//        }
//    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(HudManager())
    }
}
