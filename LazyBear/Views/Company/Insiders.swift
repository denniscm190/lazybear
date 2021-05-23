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
            
        } else {
            ProgressView()
                .onAppear {
                    // request API
                }
        }
    }
}

struct Insiders_Previews: PreviewProvider {
    static var previews: some View {
        Insiders(company: Company(), symbol: "aapl")
    }
}
