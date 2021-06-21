//
//  StockRow.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 28/3/21.
//

import SwiftUI


struct StockRow: View {
    var listName: String
    var companies: [CompanyModel]

    @State private var showList = false
    @Environment(\.managedObjectContext) private var moc
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .bottom) {
                VStack(alignment: .leading) {
                    Text(adaptListTitle(listName))
                        .font(.title3)
                        .fontWeight(.semibold)
                        .padding([.top, .horizontal])
                    
                    Text("Real-time quotes")
                        .font(.caption)
                        .opacity(0.5)
                        .padding(.horizontal)
                }
                
                Spacer()
                Button("See all", action: { showList = true })
                    .buttonStyle(BorderlessButtonStyle())
                    .padding(.horizontal)
            }
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 20) {
                    ForEach(companies, id: \.self) { company in
                        NavigationLink(destination:
                            CompanyView(symbol: company.symbol, name: company.companyName)
                                        .navigationTitle(company.symbol.uppercased())
                        ) {
                            StockItem(company: company)
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                }
                .padding()
            }
            .frame(height: 250)
        }
        .padding(.bottom)
        .sheet(isPresented: $showList) {
            StockSheet(listName: adaptListTitle(listName), companies: companies)
        }
    }
    
    /*
     Get list keys (mostactive, losers, active) and adapt them to diplay
     */
    private func adaptListTitle(_ title: String) -> String {
        if title == "mostactive" {
            return "Most active"
        } else {
            return title.capitalized
        }
    }
}


struct StockRectangleRow_Previews: PreviewProvider {
    static var previews: some View {
        StockRow(
            listName: "mostactive",
             companies: [CompanyModel(symbol: "aapl", companyName: "Apple Inc", latestPrice: 120.3, changePercent: 0.03, intradayPrices: [120.3])]
        )
    }
}
