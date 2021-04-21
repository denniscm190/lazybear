//
//  ContentView.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 21/3/21.
//

import SwiftUI

struct ContentView: View {
    @State private var showWelcome = false
    @State var selectedView = 1
    @EnvironmentObject var hudManager: HudManager
    
    var body: some View {
        ZStack {
            TabView(selection: $selectedView) {
                HomeView()
                    .tabItem {
                        Image(systemName: "house")
                        Text("Home")
                    }
                    .tag(1)  // Do not remove tags. It causes an odd behaviour when showView is activated
                SearchView()
                    .tabItem {
                        Image(systemName: "magnifyingglass")
                        Text("Search")
                    }
                    .tag(2)
                ProfileView()
                    .tabItem {
                        Image(systemName: "person")
                        Text("Profile")
                    }
                    .tag(3)
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
