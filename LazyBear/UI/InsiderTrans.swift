//
//  InsidersView.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 5/3/21.
//

import SwiftUI

struct InsiderTrans: View {
    var symbol: String
    @State private var transactions = [InsiderTranModel]()
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Image(systemName: "dollarsign.circle.fill")
                    .foregroundColor(Color(.systemGreen))
                    .imageScale(.large)
                
                Text("Latest transactions")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .padding(.horizontal)
                
                Spacer()
            }
            .padding(.horizontal)
            
            Divider()
            
            if transactions.isEmpty {
                HStack {
                    Spacer()
                    ProgressView()
                    Spacer()
                }
            }
            
            ForEach(transactions, id: \.self) { trans in
                TransRow(transaction: trans)
                    .padding(.horizontal)
                    .padding(.vertical, 5)
                
                Divider()
           }
        }
        .onAppear {
            request(url: getUrl(), model: [InsiderTranModel].self) { self.transactions = $0 }
        }
    }
    
    private func getUrl() -> String {
        let baseUrl = Bundle.main.infoDictionary?["IEX_URL"] as? String ?? "Empty url"
        let apiKey = Bundle.main.infoDictionary?["IEX_API"] as? String ?? "Empty key"
        let url = "\(baseUrl)/stock/\(symbol)/insider-transactions?token=\(apiKey)"

        return url
    }
}

struct InsiderTrans_Previews: PreviewProvider {
    static var previews: some View {
        InsiderTrans(symbol: "aapl")
    }
}
