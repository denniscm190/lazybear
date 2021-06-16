//
//  StockSheet.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 13/6/21.
//

import SwiftUI

struct StockSheet: View {
    var listName: String
    var companies: [CompanyModel]
    
    @Environment(\.presentationMode) private var stockSheetPresentation
    
    var body: some View {
        NavigationView {
            VStack {
                List(companies, id: \.self) { company in
                   StockSheetRow(company: company)
                }
            }
            .navigationTitle(listName)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {stockSheetPresentation.wrappedValue.dismiss()}) {
                        Image(systemName: "multiply")
                    }
                }
            }
        }
    }
}

struct StockSheet_Previews: PreviewProvider {
    static var previews: some View {
        StockSheet(
            listName: "Most active",
            companies: [CompanyModel(symbol: "aapl", companyName: "Apple Inc", latestPrice: 120.3, changePercent: 0.03, intradayPrices: [120.3])]
        )
    }
}
