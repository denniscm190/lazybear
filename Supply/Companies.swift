//
//  Companies.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 27/12/20.
//

import SwiftUI

struct Companies: View {
    var colours = [Color(.systemBlue), Color(.systemYellow), Color(.systemRed), Color(.systemGreen), Color(.systemIndigo), Color(.systemOrange), Color(.systemPink), Color(.systemPurple), Color(.systemTeal), Color(.systemRed)]
    
    var names = ["adobe", "amazon", "apple", "facebook", "google", "jp", "netflix", "paypal", "salesforce", "tesla"]
    var ciks = [796343, 1018724, 320193, 1326801, 1652044, 19617, 1065280, 1633917, 1108524, 1318605]
    var symbols = ["adbe", "amzn", "aapl", "fb", "googl", "amj", "nflx", "pypl", "crm", "tsla"]
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 20) {  // Create ScrollView with two columns per row
                ForEach((0...9), id: \.self) { index in
                    NavigationLink(destination: Company(cik: ciks[index], symbol: symbols[index], name: names[index])
                                    .navigationBarTitle(names[index].capitalized)
                    ) {
                        VStack {
                            Image(names[index])
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                            
                            Text(names[index].capitalized)
                                .foregroundColor(.white)
                                .fontWeight(.bold)
                        }
                        .padding(40)
                        .background(colours[index].cornerRadius(20))
                    }
                }
            }
            .padding()
        }
    }
}

struct Companies_Previews: PreviewProvider {
    static var previews: some View {
        Companies()
    }
}
