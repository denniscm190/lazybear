//
//  WatchlistRow.swift
//  lazybear
//
//  Created by Dennis Concepción Martín on 17/07/2021.
//

import SwiftUI
import Alamofire

struct WatchlistRow: View {
    var symbol: String
    @State private var companyQuote = CompanyQuoteModel()
    @State private var showingRow  = false
    
    var body: some View {
        HStack {
            if showingRow {
                VStack(alignment: .leading) {
                    Text("\(symbol)")
                        .font(.headline)
                    
                    Text("\(companyQuote.companyName!)")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                
                Spacer()
                VStack(alignment: .trailing) {
                    Text("\(companyQuote.latestPrice!, specifier: "%.2f")")
                        .font(.headline)
                    
                    Text("\(companyQuote.change!, specifier: "%.2f") \(companyQuote.changePercent!*100, specifier: "%.2f")%")
                        .font(.subheadline)
                        .foregroundColor(generateColour())
                }
            } else {
                ProgressView()
            }
        }
        .onAppear(perform: requestApi)
    }
    
    private func generateColour() -> Color {
        if companyQuote.change! >= 0 {
            return Color(.systemGreen)
        } else {
            return Color(.systemRed)
        }
    }
    
    private func requestApi() {
        let url = "https://cloud.iexapis.com/stable/stock/\(symbol)/quote?token=pk_58fd944e924e4a70acf8635bc335cec4"
        AF.request(url).responseDecodable(of: CompanyQuoteModel.self) { response in
            if let value = response.value {
                self.companyQuote = value
                self.showingRow = true
            }
            else {
                // Handle error
            }
        }
    }
}

struct WatchlistRow_Previews: PreviewProvider {
    static var previews: some View {
        WatchlistRow(symbol: "AAPL")
    }
}
