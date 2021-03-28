//
//  ContentView.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 21/3/21.
//

import SwiftUI

struct ContentView: View {
    @State private var showWelcome = false
    
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Image(systemName: "house")
                    Text("Home")
                }
            Text("Another Tab")
                .tabItem {
                    Image(systemName: "2.square.fill")
                    Text("Second")
                }
            Text("The Last Tab")
                .tabItem {
                    Image(systemName: "3.square.fill")
                    Text("Third")
                }
        }
//        .onAppear { isAppAlreadyLaunchedOnce() }
        .sheet(isPresented: $showWelcome) {
            
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
    }
}
