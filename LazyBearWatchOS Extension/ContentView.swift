//
//  ContentView.swift
//  LazyBearWatchOS Extension
//
//  Created by Dennis Concepción Martín on 19/6/21.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            ForEach((1..<4)) { _ in
                Text("Hello")
            }
            .navigationTitle("Lazybear")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
