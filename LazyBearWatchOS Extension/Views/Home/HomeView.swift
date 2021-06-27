//
//  HomeView.swift
//  LazyBearWatchOS Extension
//
//  Created by Dennis Concepción Martín on 22/6/21.
//

import SwiftUI
import CoreData

struct HomeView: View {
    @ObservedObject var profile = Profile()

    @FetchRequest(entity: WatchlistCompany.entity(), sortDescriptors: []) var watchlistCompanies: FetchedResults<WatchlistCompany>
    
    @State private var timer = Timer.publish(every: 10, on: .main, in: .common).autoconnect()  /// Set recurrent price request
    
    var body: some View {
        if profile.showView {
            NavigationView {
                ScrollView {
                    VStack {
                        if let companies = profile.data.quotes {
                            ForEach(companies, id: \.self) { company in
                                CompanyRow(company: company)
                            }
                        }
                    }
                }
                .navigationTitle("Lazybear")
                .onAppear { self.timer = Timer.publish(every: 10, on: .main, in: .common).autoconnect() }  /// Start timer
                .onDisappear { self.timer.upstream.connect().cancel() }  /// Stop timer
                .onReceive(timer) { _ in prepareUrl(.streaming) }
            }
        } else {
            ProgressView()
                .onAppear { prepareUrl(.initial) }
        }
    }
    
    /*
     Get symbols in watchlists (Core Data) -> Prepare url -> Request
     */
    private func prepareUrl(_ requestType: RequestType) {
        let symbols = Set(watchlistCompanies.map { $0.symbol })
        let symbolsString = symbols.joined(separator:",")
        
        switch requestType {
        case .initial:
            let url = "https://api.lazybear.app/profile/type=initial/symbols=\(symbolsString)"
            print(watchlistCompanies)
            profile.request(url, .initial)
            
        default:
            let url = "https://api.lazybear.app/profile/type=streaming/symbols=\(symbolsString)"
            profile.request(url, .streaming)
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
