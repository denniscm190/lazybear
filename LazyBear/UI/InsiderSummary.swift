//
//  InsiderSummary.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 5/3/21.
//

import SwiftUI

struct InsiderSummary: View {
    var symbol: String
    @State private var insiderSummary = [InsiderSummaryModel]() {didSet { print(insiderSummary) }}
    
    var body: some View {
        let maxPosition = insiderSummary.map { ($0.position ?? 0) }.max()
        VStack(alignment: .leading) {
            HStack {
                Text("Top insiders")
                    .font(.title)
                    .fontWeight(.semibold)
                
                Spacer()
            }
            .padding(.bottom)
            
            ForEach(insiderSummary.indices, id: \.self) { index in
                if index < 3 {  // Number of rows that I want to show
                    let name = insiderSummary[index].entityName
                    let position = insiderSummary[index].position ?? 1
                    let pct = getPercentage(maxPosition ?? 1, position)
                    HorizontalBar(text: name, data: position, capsulePctWidth: pct)
                }
            }
        }
        .padding()
        .onAppear {
            let url = getUrl(endpoint: .insiderSummary, symbol: symbol)
            request(url: url, model: [InsiderSummaryModel].self) { self.insiderSummary = $0 }
        }
    }
    
    private func getPercentage(_ maxValue: Int, _ value: Int) -> CGFloat {
        let pct = Double(value) / Double(maxValue)
        
        return CGFloat(pct)
    }
}

struct InsiderSummary_Previews: PreviewProvider {
    static var previews: some View {
        InsiderSummary(symbol: "aapl")
    }
}
