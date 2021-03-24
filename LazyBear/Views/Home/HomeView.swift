//
//  HomeView.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 24/3/21.
//

import SwiftUI

struct HomeView: View {
    @State private var searchText = ""
    
    var body: some View {
    NavigationView {
        GeometryReader { geo in
            VStack {
                UserHelper()
                    .padding(.top)
                }
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
