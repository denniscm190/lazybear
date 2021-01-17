//
//  Companies.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 27/12/20.
//

import SwiftUI

struct Companies: View {
    @Environment(\.verticalSizeClass) var verticalSizeClass: UserInterfaceSizeClass?
    @Environment(\.horizontalSizeClass) var horizontalSizeClass: UserInterfaceSizeClass?
    
    var names = ["adobe", "amazon", "apple", "facebook", "google", "jp morgan", "netflix", "paypal", "salesforce", "tesla", "berkshire h.", "visa", "walt disney", "bofa", "pfizer", "intel"]
    var ciks = [796343, 1018724, 320193, 1326801, 1652044, 19617, 1065280, 1633917, 1108524, 1318605, 1067983, 1403161, 1744489, 70858, 78003, 50863]
    var symbols = ["adbe", "amzn", "aapl", "fb", "googl", "amj", "nflx", "pypl", "crm", "tsla", "brk.b", "v", "dis", "bac", "pfe", "intc"]
    var colours = [Color(.systemBlue), Color(.systemGreen), Color(.systemIndigo), Color(.systemOrange), Color(.systemPink), Color(.systemPurple), Color(.systemRed), Color(.systemTeal), Color(.systemYellow), Color(.systemBlue), Color(.systemGreen), Color(.systemIndigo), Color(.systemOrange), Color(.systemPink), Color(.systemPurple), Color(.systemRed)]
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns(), spacing: 20) {
                ForEach((0...15), id: \.self) { index in
                    NavigationLink(destination: Company(cik: ciks[index], symbol: symbols[index], name: names[index])
                                    .navigationBarTitle(names[index].capitalized)
                    ) {
                        VStack {
                            Image(symbols[index])
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
    
    // Change number of columns depend on the device
    func columns() -> [GridItem] {
        var columns = [GridItem]()
        if horizontalSizeClass == .compact && verticalSizeClass == .regular {
            print("Running on iPhone")
            columns = Array(repeating: .init(.flexible()), count: 2)
        }
        else if horizontalSizeClass == .regular && verticalSizeClass == .regular {
            print("Running on iPad")
            columns = Array(repeating: .init(.flexible()), count: 4)
        }
        
        return columns
        
    }
}

struct Companies_Previews: PreviewProvider {
    static var previews: some View {
        Companies()
    }
}
