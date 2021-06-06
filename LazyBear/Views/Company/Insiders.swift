//
//  Insiders.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 23/5/21.
//

import SwiftUI

struct Insiders: View {
    @ObservedObject var company: Company
    var symbol: String
    
    var body: some View {
        if company.showInsidersView {
            if let insiderSummer = company.insidersData.insiderRoster {
                VStack(alignment: .leading) {
                    Text("Top 10 insiders")
                        .font(.title3)
                        .fontWeight(.semibold)
                
                    // Get total shares owned by the top 10 insiders
                    let totalPositions =  insiderSummer.map { $0.position }.reduce(0, +)
                    VStack(alignment: .leading, spacing: 20) {
                        ForEach(insiderSummer.prefix(10), id: \.self) { insider in
                            
                            // Compute percentage of ownership for each insider
                            let percentage = Double(insider.position) / Double(totalPositions)
                            
                            InsiderRow(percentageOfWidth: CGFloat(percentage), insiderRoster: insider)
                        }
                    }
                }
            }
        } else {
            ProgressView()
                .onAppear {
                   let url = "https://api.lazybear.app/company/insiders/symbol=\(symbol)"
                    company.request(url, .initial, "insider")
                }
        }
    }
}

struct Insiders_Previews: PreviewProvider {
    static var previews: some View {
        Insiders(company: Company(), symbol: "aapl")
    }
}
