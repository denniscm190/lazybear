//
//  HomeView.swift
//  LazyBearWatchOS Extension
//
//  Created by Dennis Concepción Martín on 22/6/21.
//

import SwiftUI
import CoreData

struct HomeView: View {
    @FetchRequest(entity: WatchlistCompany.entity(), sortDescriptors: [])
    var watchlistCompanies: FetchedResults<WatchlistCompany>
    
    var body: some View {
        VStack {
            
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
