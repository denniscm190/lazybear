//
//  WatchOSCompanyView.swift
//  LazyBearWatchOS Extension
//
//  Created by Dennis Concepción Martín on 27/06/2021.
//

import SwiftUI

struct WatchOSCompanyView: View {
    var symbol: String
    @ObservedObject var company = Company()
    @State private var timer = Timer.publish(every: 10, on: .main, in: .common).autoconnect()  /// Set recurrent price request
    
    var body: some View {
        if company.showView {
            ScrollView {
                VStack(alignment: .leading) {
                    Text(symbol)
                        .fontWeight(.semibold)
                    
                    WatchOSChartHelper(company: company)
                        .padding(.bottom)
                    
                    NavigationLink("Latest news", destination: WatchOSNewsList(latestNews: company.data.latestNews).navigationTitle("Latest news"))
                    
                    Text("Real-time data")
                        .font(.footnote)
                        .opacity(0.7)
                        .padding(.top)
                }
                .onAppear { self.timer = Timer.publish(every: 10, on: .main, in: .common).autoconnect() }  /// Start timer
                .onDisappear { self.timer.upstream.connect().cancel() }  /// Stop timer
                .onReceive(timer) { _ in company.request("https://api.lazybear.app/company/symbol=\(symbol)/type=initial/range=5d", .streaming) }
            }
        } else {
            ProgressView()
                .onAppear {
                    company.request("https://api.lazybear.app/company/symbol=\(symbol)/type=initial/range=5d", .initial)
                }
        }
    }
}

struct WatchOSCompanyView_Previews: PreviewProvider {
    static var previews: some View {
        WatchOSCompanyView(symbol: "AAPL")
            .navigationTitle("Apple Inc")
    }
}
